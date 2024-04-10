class EventsController < ApplicationController
    before_action :authenticate_user!  
    before_action :set_event, only: [:show, :update, :destroy]
  
    def index
      @events = Event.all
      render json: @events
    end
  
    def show
      render json: @event
    end
  
    def create
      @event = Event.new(event_params)
  
      if @event.save
        render json: @event, status: :created, location: @event
      else
        render json: @event.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @event.update(event_params)
        render json: @event
      else
        render json: @event.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @event.destroy
      head :no_content
    end  
  
    private
  
    def set_event
      @event = current_user.events.find(params[:id])
      rescue ActiveRecord::RecordNotFound
      render json: { error: "Event not found" }, status: :not_found
    end
  
      def event_params
        params.require(:event).permit(:name, :date, :user_id)
      end
  end
  