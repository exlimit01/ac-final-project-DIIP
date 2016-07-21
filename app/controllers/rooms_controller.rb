class RoomsController < ApplicationController

  before_action :set_room

  def show

    interaction = Interaction.find(params[:interaction_id])
    @talk = @room.talks.new
    @talks = @room.talks.order(updated_at: :desc)

    # friend_id 用來辨識回上一頁的路徑
    @friend_id =  (current_user.id == interaction.friendship.user_id )? interaction.friendship.friend_id : interaction.friendship.user_id

    @hide_star = params[:hide_star]

  end

  protected

  def set_room
    @room = Room.find(params[:id])
  end


end
