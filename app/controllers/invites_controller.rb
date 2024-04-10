class InvitesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_invite, only: [:destroy]

  def create
    @invite = current_user.events.find(invite_params[:event_id]).invites.new(invite_params)
    if @invite.save
      render json: @invite, status: :created
    else
      render json: @invite.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @invite.destroy
    head :no_content
  end

  private

  def set_invite
    @invite = current_user.events.find(params[:event_id]).invites.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    render json: { error: "Invite not found" }, status: :not_found
  end

  def invite_params
    params.require(:invite).permit(:participant_id, :event_id)
  end
end
