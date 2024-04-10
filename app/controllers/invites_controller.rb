class InvitesController < ApplicationController

    def create
      @invite = Invite.new(invite_params)
      if @invite.save
        render json: @invite, status: :created
      else
        render json: @invite.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @invite = Invite.find(params[:id])
      @invite.destroy
      head :no_content
    end
  
    private
  
      def invite_params
        params.require(:invite).permit(:participant_id, :event_id)
      end
  end