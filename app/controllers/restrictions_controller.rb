class RestrictionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_restriction, only: [:show, :update, :destroy]
  
    def index
      @restrictions = Restriction.all
      render json: @restrictions
    end
  
    def show
      render json: @restriction
    end
  
    def create
      @restriction = Restriction.new(restriction_params)
      if @restriction.save
        render json: @restriction, status: :created, location: @restriction
      else
        render json: @restriction.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @restriction.update(restriction_params)
        render json: @restriction
      else
        render json: @restriction.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @restriction.destroy
      head :no_content
    end
  
    private
  
    def set_restriction
      @restriction = current_user.events.find(params[:event_id]).restrictions.find(params[:id])
      rescue ActiveRecord::RecordNotFound
      render json: { error: "Restriction not found" }, status: :not_found
    end
  
      def restriction_params
        params.require(:restriction).permit(:event_id, :participant_id, :cannot_give_to_id)
      end
  end
  