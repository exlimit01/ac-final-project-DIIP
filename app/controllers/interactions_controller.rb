class InteractionsController < ApplicationController

  def ask
    user_id = params[:user_id]
    friend_id = params[:friend_id]
    mission_id = params[:mission_id]

    friendship = Friendship.find_by(:user_id => user_id, :friend_id => friend_id)

    Interaction.create!(:friendship => friendship, :mission_id => mission_id, :status => "request" )
    redirect_to :back
  end

  def reset
    friendship = current_user.friendships.find_by(friend_id: params[:friend_id])
    m = Mission.all.sample
    @current_interaction_item = []
    @current_interaction_item << friendship.interactions.new(mission_id: m.id, status: "none")

    # 已完成任務
    @done_interactions = friendship.interactions.where(status: "done").order(updated_at: :desc)

    respond_to do |format|
      format.js
    end
  end

  def ok
    @interaction = Interaction.find(params[:interaction_id])
    @interaction.update!(:status => "accept")

    inverse_user_id = @interaction.friendship.friend_id
    inverse_friend_id = @interaction.friendship.user_id
    mission_id = @interaction.mission_id

    f = Friendship.find_by(:user_id => inverse_user_id, :friend_id => inverse_friend_id )
    i = Interaction.create!(:friendship_id => f.id, :mission_id => mission_id, :status => "accept")

    @current_interaction_item = []
    @current_interaction_item << @interaction

    # 任務接受後 建立一個Room
    room = Room.create!(:user_id1 => @interaction.friendship.user_id,
                 :user_id2 => @interaction.friendship.friend_id,
                 :interaction_id1 => @interaction.id,
                 :interaction_id2 => i.id,
                 :mission_id => @interaction.mission_id)

    @interaction.room = room
    @interaction.save
    i.room = room
    i.save
    # respond_to do |format|
    #   format.js
    # end

    # 回list
    redirect_to interactions_list_path(friend_id: @interaction.friendship.user_id)

  end

  def no

    # 拒絕別人
    @interaction = Interaction.find(params[:interaction_id])
    @interaction.update!(:status => "reject")

    if params[:double]

      inverse_user_id = @interaction.friendship.friend_id
      inverse_friend_id = @interaction.friendship.user_id
      mission_id = @interaction.mission_id

      f = Friendship.find_by(:user_id => inverse_user_id, :friend_id => inverse_friend_id )
      i = Interaction.find_by(:friendship_id => f.id, :mission_id => mission_id, :status => "accept")
      i.update!(:status => "reject")

    end

    if params[:opposite]
      # 回list (反向)
    redirect_to interactions_list_path(friend_id: @interaction.friendship.user_id)
    else
      # 回list (正向)
    redirect_to interactions_list_path(friend_id: @interaction.friendship.friend_id)
    end


  end

   def done

    room_id = params[:room_id]
    friend_id = params[:friend_id]

    # 房間關閉
    room = Room.find(params[:room_id])
    room.update!(:active => false)

    # 找到關係並更新
    friendship = Friendship.find_by(user_id: current_user.id, friend_id: friend_id)
    friendship.love_level += params[:star].to_i
    friendship.save

    # 找到互動並更新
    interaction = Interaction.find_by(room_id: room_id, friendship_id: friendship.id)
    interaction.status = "done"
    interaction.save

    redirect_to interactions_list_path(friend_id: friend_id)

   end

  def list

    # 好友列表
    @friendships = []
    current_user.friendships.each do |f|
      if f.mission_open?
        @friendships << f
      end
    end

    @current_inverse_interactions = []

    if params[:friend_id].present?

      # 自己與對方的friendship
      friendship = current_user.friendships.find_by(friend_id: params[:friend_id])
      inverse_friendship = Friendship.find_by(user_id: params[:friend_id], friend_id: current_user.id)

      # 先看對方的任務要求 對方已有提出的話就看不到新任務
      @current_inverse_interactions = inverse_friendship.interactions.where("status = ?", "request")

      if @current_inverse_interactions.count == 0
        # 對好友的隨機任務 (要求中:request 已接受:accept 完成:done)
        current_interaction = friendship.interactions.where("status = ? or status = ?", "request", "accept")
        if current_interaction.count == 0
          m = Mission.all.sample
          @current_interaction_item = []
          @current_interaction_item << friendship.interactions.new(mission_id: m.id, status: "none")
        else
          @current_interaction_item = current_interaction
        end
      end
      # 已完成任務
      @done_interactions = friendship.interactions.where(status: "done").order(updated_at: :desc)
    end

  end

end
