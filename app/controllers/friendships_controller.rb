class FriendshipsController < ApplicationController

  def like
    friendships = current_user.friendships.where(friend_id: params[:friend_id])
    if friendships.count == 0
      friendships.create(friend_id: params[:friend_id], status: "liked" )
    else
      friendships.first.update(friend_id: params[:friend_id], status: "liked" )
    end
    redirect_to :back
  end

  def none
    friendships = current_user.friendships.where(friend_id: params[:friend_id])
    if friendships.count == 0
      friendships.create(friend_id: params[:friend_id], status: "none" )
    else
      friendships.first.update(friend_id: params[:friend_id], status: "none" )
    end
    redirect_to :back

  end

  def block
    friendships = current_user.friendships.where(friend_id: params[:friend_id])
    if friendships.count == 0
      friendships.create(friend_id: params[:friend_id], status: "blocked" )
    else
      friendships.first.update(friend_id: params[:friend_id], status: "blocked" )
    end
    redirect_to :back

  end

end
