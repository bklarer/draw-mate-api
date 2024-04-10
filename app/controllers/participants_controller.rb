class ParticipantsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_participant, only: [:show, :update, :destroy]
  
    def index
      @participants = Participant.all
      render json: @participants
    end
  
    def show
      render json: @participant
    end
  
    def create
      @participant = Participant.new(participant_params)
      if @participant.save
        render json: @participant, status: :created, location: @participant
      else
        render json: @participant.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @participant.update(participant_params)
        render json: @participant
      else
        render json: @participant.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @participant.destroy
      head :no_content
    end
  
    private
  
    def set_participant
      @participant = current_user.events.find(params[:event_id]).participants.find(params[:id])
      rescue ActiveRecord::RecordNotFound
      render json: { error: "Participant not found" }, status: :not_found
    end
  
      def participant_params
        params.require(:participant).permit(:first_name, :last_name, :email, :user_id)
      end
  end
  