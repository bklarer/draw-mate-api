class DrawingsController < ApplicationController
    before_action :set_drawing, only: [:show, :update, :destroy]
    before_action :set_event, only: [:persisted_drawing]
  
    def index
      @drawings = Drawing.all
      render json: @drawings
    end
 
    def show
      render json: @drawing
    end
  
    def create
      @drawing = Drawing.new(drawing_params)
      if @drawing.save
        render json: @drawing, status: :created, location: @drawing
      else
        render json: @drawing.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @drawing.update(drawing_params)
        render json: @drawing
      else
        render json: @drawing.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @drawing.destroy
      head :no_content
    end
  
        # TODO: Make sure auth is disabled
    def create_fast_draw
        participants = params[:participants].map do |p|
            { id: p[:id], restricted_ids: p[:restricted_ids] }
        end
        
        begin
            result = DrawingService.perform(participants)
            render json: { drawings: result }
        rescue StandardError => e
            render json: { error: e.message }, status: :unprocessable_entity
        end
    end

    def persisted_drawing
        provided_participant_ids = params[:participants].map { |p| p[:id] }
        actual_participant_ids = @event.participants.pluck(:id)
    
        unless (provided_participant_ids - actual_participant_ids).empty?
          render json: { error: "Some participants do not belong to the specified event." }, status: :unprocessable_entity and return
        end
    
        participants = @event.participants.map do |participant|
          {
            id: participant.id,
            restricted_ids: participant.restrictions.pluck(:cannot_give_to_id)
          }
        end
    
        begin
          results = DrawingService.perform(participants)
          
          ActiveRecord::Base.transaction do
            results.each do |result|
              Drawing.create!(
                event: @event,
                giver_id: result[:giver_id],
                receiver_id: result[:receiver_id]
              )
            end
          end
          
          all_drawings = @event.drawings.select(:id, :giver_id, :receiver_id)
          render json: { message: 'Drawing completed successfully.', drawings: all_drawings }, status: :ok
        rescue ActiveRecord::RecordInvalid => e
          render json: { error: e.message }, status: :unprocessable_entity
        rescue => e
          render json: { error: "Drawing failed: #{e.message}" }, status: :unprocessable_entity
        end
      end


    private
  
      def set_drawing
        @drawing = Drawing.find(params[:id])
      end

      def set_event
        @event = Event.find(params[:event_id])
      end

      def drawing_params
        params.require(:drawing).permit(:giver_id, :receiver_id, :event_id)
      end
  end