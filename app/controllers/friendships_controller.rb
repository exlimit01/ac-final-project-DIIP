class FriendshipsController < ApplicationController

  def like
    # 跟對方沒建過關係的話 就建立一筆喜歡
    # 跟對方有過關係的話 就更新為喜歡
    friendships = current_user.friendships.where(friend_id: params[:friend_id])
    if friendships.count == 0
      Friendship.create(user_id: current_user.id, friend_id: params[:friend_id], status: "liked", :love_level => 6 )
    else
      friendships.first.update(user_id: current_user.id, friend_id: params[:friend_id], status: "liked", :love_level => 6 )
    end

    # 對方跟你沒建過關係的話 建立一筆反向的無的關係
    inverse_friendships = Friendship.where(:user_id => params[:friend_id], :friend_id => current_user.id, :love_level => 0)
    if inverse_friendships.count == 0
      Friendship.create(user_id: params[:friend_id], friend_id: current_user.id, status: "none", :love_level => 0 )
    end

    redirect_to :back
  end

  def none
    # 跟對方沒建過關係的話 就建立一筆無的關係
    friendships = current_user.friendships.where(friend_id: params[:friend_id])
    if friendships.count == 0
      Friendship.create(user_id: current_user.id, friend_id: params[:friend_id], status: "none", :love_level => 0 )
    else
      friendships.first.update(friend_id: params[:friend_id], status: "none", :love_level => 0 )
    end

    # 對方跟你沒建過關係的話 建立一筆反向的無的關係
    inverse_friendships = Friendship.where(:user_id => params[:friend_id], :friend_id => current_user.id, :love_level => 0 )
    if inverse_friendships.count == 0
      Friendship.create(user_id: params[:friend_id], friend_id: current_user.id, status: "none", :love_level => 0 )
    end

    redirect_to :back

  end

  def block

    # 跟對方沒建過關係的話 就建立一筆封鎖
    # 跟對方有過關係的話 就更新為封鎖
    friendships = current_user.friendships.where(friend_id: params[:friend_id])
    if friendships.count == 0
      Friendship.create(user_id: current_user.id, friend_id: params[:friend_id], status: "blocked", :love_level => 0 )
    else
      friendships.first.update(friend_id: params[:friend_id], status: "blocked", :love_level => 0 )
    end

    # 對方跟你沒建過關係的話 建立一筆反向的無的關係
    inverse_friendships = Friendship.where(:user_id => params[:friend_id], :friend_id => current_user.id, :love_level => 0)
    if inverse_friendships.count == 0
      Friendship.create(user_id: params[:friend_id], friend_id: current_user.id, status: "none", :love_level => 0 )
    end

    redirect_to :back

  end

  def list

    # 好友列表
    @friendships = current_user.friendships.where(status: "liked")

=begin
    @current_inverse_interactions = []

    if params[:friend_id].present?

      # 自己與對方的friendship
      friendship = current_user.friendships.find_by(friend_id: params[:friend_id])
      inverse_friendship = Friendship.find_by(user_id: params[:friend_id], friend_id: current_user.id)

      # 對好友的隨機任務 (要求中:request 已接受:accept 完成:done)
      current_interaction = friendship.interactions.where("status = ? or status = ?", "request", "accept")
      if current_interaction.count == 0
        num = rand(31..35)
        #m = Mission.all.sample

        m = Mission.find(num)
        @current_interaction_item = friendship.interactions.new(mission_id: m.id, status: "none")

      else
        @current_interaction_item = current_interaction
      end

      # 對方的任務要求
      @current_inverse_interactions = inverse_friendship.interactions.where("status = ?", "request")

      # 已完成任務
      @done_interactions = friendship.interactions.where(status: "done")
    end
=end

  end

end
