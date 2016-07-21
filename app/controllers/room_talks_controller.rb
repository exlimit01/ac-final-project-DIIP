class RoomTalksController < ApplicationController

  before_action :set_room

  def create

    @talk = @room.talks.new(talk_param)
    @talk.author = current_user.id
    @talk.save

    redirect_to :back

  end

  protected

  def set_room
    @room = Room.find(params[:room_id])
  end

  def talk_param
    params.require(:talk).permit(:content)
  end

end
