class RoomsController < ApplicationController

  before_action :set_room

  def show
    interaction = Interaction.find(params[:interaction_id])
    @talk = @room.talks.new
    @talks = @room.talks.order(updated_at: :desc)

    # friend_id 用來辨識回上一頁的路徑
    @friend_id =  (current_user.id == interaction.friendship.user_id )? interaction.friendship.friend_id : interaction.friendship.user_id

=begin
    show_status = params[:co_status].to_i
    if show_status == 6 || show_status == 8
      @hide_star = true
    else
      @hide_star = false
    end
=end

    # 暫時先這樣用(模擬測試)
    @interaction = interaction
    @step = params[:step]
    @friend = User.find(@friend_id)
  end

  protected

  def set_room
    @room = Room.find(params[:id])
  end

end
