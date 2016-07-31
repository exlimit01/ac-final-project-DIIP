class V2InteractionsController < ApplicationController

  def list
    # 列出任務list
    # 搜尋最近一筆的任務，如果找到雙向都不為accept或都不為done且超過24小時的話，刪掉兩筆

    # 再找一次
    # 如果沒找到的話，隨機產生一筆任務，並雙向指派給這兩個人

    # 好友列表
    @friendships = []
    current_user.friendships.each do |f|
      if f.mission_open?
        @friendships << f
      end
    end

    if params[:friend_id].present?
      # 雙方往來的friendship
      friendship = current_user.friendships.find_by(friend_id: params[:friend_id])
      inverse_friendship = Friendship.find_by(user_id: params[:friend_id], friend_id: current_user.id)

      # 都沒生成過任務的話
      if friendship.interactions.count == 0
=begin
        m = Mission.all.sample
        # 生成一筆正向的
        @current_interaction_item = []
        @current_interaction_item << friendship.interactions.create!(mission_id: m.id, co_status: 0)
        # 產生一筆反向的
        inverse_friendship.interactions.create!(mission_id: m.id, co_status: 0)
=end
      else
        # 有生成過任務的話
        my_last_status = friendship.interactions.last.co_status
        friend_last_status = inverse_friendship.interactions.last.co_status
        # 搜尋最近一筆的任務，如果找到雙向為all_done的話，再生成兩筆
        if my_last_status == 8 || friend_last_status == 8
          #m = Mission.all.sample
          # 生成一筆正向的
          @current_interaction_item = []
          #@current_interaction_item << friendship.interactions.create!(mission_id: m.id, co_status: 0)
          # 產生一筆反向的
          #inverse_friendship.interactions.create!(mission_id: m.id, co_status: 0)
        else
          @current_interaction_item = []
          @current_interaction_item << friendship.interactions.last
        end
      end

      # my_last_updated_time = friendship.interactions.last.updated_at
      # hour_diff = (Time.now - my_last_updated_time) / 1.hours

      # 已完成任務
        @done_interactions = friendship.interactions.where(co_status: 8).order(updated_at: :desc)
    end

  end

  def ok

    # 取出進來的任務
    @interaction = Interaction.find(params[:interaction_id])

    # 分析任務並取出對應的反向關係
    inverse_user_id = @interaction.friendship.friend_id
    inverse_friend_id = @interaction.friendship.user_id
    mission_id = @interaction.mission_id

    # 先看對方的狀態(照對方的狀態決定自己的狀態會被寫成什麼)
    f = Friendship.find_by(:user_id => inverse_user_id, :friend_id => inverse_friend_id )
    i = f.interactions.last

    if i.v2_all_none?
      # 如果對方未開始，自己的狀態改為accept_and_wait，對方的狀態改為other_accept
      @interaction.update!(:co_status => 2)
      i.co_status = 1
      i.save
    elsif i.v2_other_accept?
      # 不會有這條路
    elsif i.v2_accept_and_wait?

      # 如果對方是在等待自己的話，兩邊的狀態都改為start

      # 任務接受後 建立一個Room
      room = Room.create!(:user_id1 => @interaction.friendship.user_id,
                 :user_id2 => @interaction.friendship.friend_id,
                 :interaction_id1 => @interaction.id,
                 :interaction_id2 => i.id,
                 :mission_id => @interaction.mission_id)


      @interaction.update!(:co_status => 5, :room_id => room.id)
      i.co_status = 5
      i.room = room
      i.save

    elsif i.v2_other_reject?
      # 不會有這條路
    elsif i.v2_reject_other?
      # 對方已經拒絕，改自己的狀態為reject_by_other
      @interaction.update!(:co_status => 3)
    elsif i.v2_start?
      # 不會有這條路
    elsif i.v2_me_done?
      # 不會有這條路
    elsif i.v2_other_done?
      # 不會有這條路
    elsif i.v2_all_done?
      # 不會有這條路
    end

    # 顯示現在的任務狀態
    @current_interaction_item = []
    @current_interaction_item << @interaction

    # 回list
    redirect_to v2_interactions_list_path(friend_id: @interaction.friendship.friend_id)

  end

  def no

    # 取出進來的任務
    @interaction = Interaction.find(params[:interaction_id])

    # 分析任務並取出對應的反向關係
    inverse_user_id = @interaction.friendship.friend_id
    inverse_friend_id = @interaction.friendship.user_id
    mission_id = @interaction.mission_id

    # 先看對方的狀態(照對方的狀態決定自己的狀態會被寫成什麼)
    f = Friendship.find_by(:user_id => inverse_user_id, :friend_id => inverse_friend_id )
    i = f.interactions.last

    if i.v2_all_none?
      # 如果對方未開始，自己的狀態改為reject_other，對方的狀態改為other_reject
      @interaction.update!(:co_status => 4)
      i.co_status = 3
      i.save
    elsif i.v2_other_accept?
      # 不會有這條路
    elsif i.v2_accept_and_wait?
      # 如果對方是在等待自己的話，自己改為reject_other 對方改為other_reject
      @interaction.update!(:co_status => 4)
      i.co_status = 3
      i.save
    elsif i.v2_other_reject?
      # 不會有這條路
    elsif i.v2_reject_other?
      # 對方已經拒絕，改自己的狀態為other_reject
      @interaction.update!(:co_status => 3)
    elsif i.v2_start?
      # 不會有這條路
    elsif i.v2_me_done?
      # 不會有這條路
    elsif i.v2_other_done?
      # 不會有這條路
    elsif i.v2_all_done?
      # 不會有這條路
    end

    # 顯示現在的任務狀態
    @current_interaction_item = []
    @current_interaction_item << @interaction

    # 回list
    redirect_to v2_interactions_list_path(friend_id: @interaction.friendship.friend_id)

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

    # 找到互動
    interaction = Interaction.find_by(room_id: room_id, friendship_id: friendship.id)


    # 找到對方互動來判斷自己的互動狀態
    f = Friendship.find_by(user_id: friend_id, friend_id: current_user.id)
    i = f.interactions.last

    if i.v2_start?
      # 對方狀態還是start 改自己的狀態為me_done 對方的狀態改為 other_done
      interaction.co_status = 6
      interaction.save
      i.co_status = 7
      i.save

    elsif i.v2_me_done?
      # 對方狀態為me_done 則兩人的狀態都改為all_done
      interaction.co_status = 8
      interaction.save
      i.co_status = 8
      i.save
    elsif i.v2_other_done?
      # 不會有這條
    elsif i.v2_all_done?
      # 不會有這條
    end

    redirect_to v2_interactions_list_path(friend_id: friend_id)

  end

  def refresh

    Friendship.all.each do |friendship|
      if friendship.mission_open?

        if friendship.interactions.count == 0 || friendship.interactions.last.co_status == 8

          user_id = friendship.user_id
          friend_id = friendship.friend_id
          inverse_friendship = Friendship.find_by(user_id: friend_id, friend_id: user_id)

          m = Mission.all.sample
          friendship.interactions.create!(:mission_id => m.id, :co_status => -1)
          inverse_friendship.interactions.create!(:mission_id => m.id, :co_status => -1)

        elsif friendship.interactions.last.co_status < 5 && friendship.interactions.last.co_status != -1

          user_id = friendship.user_id
          friend_id = friendship.friend_id
          inverse_friendship = Friendship.find_by(user_id: friend_id, friend_id: user_id)

          m = Mission.all.sample
          friendship.interactions.last.update!(:mission_id => m.id, :co_status => -1)
          inverse_friendship.interactions.last.update!(:mission_id => m.id, :co_status => -1)

        end

      end
    end

    Interaction.where(:co_status => -1).update(:co_status => 0)

    redirect_to :back
  end

  def simu_matching_mission

    # 好友雙方好感度都加15
    friendship = Friendship.find_by(user_id: current_user.id, friend_id: params[:friend_id])
    inverse_friendship = Friendship.find_by(user_id: params[:friend_id], friend_id: current_user.id)
    friendship.love_level += 15
    friendship.save
    inverse_friendship.love_level += 15
    inverse_friendship.save

    room = Room.find(params[:room_id])
    room.interactions.each do |interaction|
      interaction.co_status = 8
      interaction.save
    end

    # 完成以後導回原畫面
    redirect_to room_path(params[:room_id], :co_status => 5, interaction_id: params[:interaction_id], step: "pass")
  end

  def simu_go_out_mission

      # 好友雙方好感度都加15
    friendship = Friendship.find_by(user_id: current_user.id, friend_id: params[:friend_id])
    inverse_friendship = Friendship.find_by(user_id: params[:friend_id], friend_id: current_user.id)
    friendship.love_level += 15
    friendship.save
    inverse_friendship.love_level += 15
    inverse_friendship.save

    room = Room.find(params[:room_id])
    room.interactions.each do |interaction|
      interaction.co_status = 8
      interaction.save
    end

    # 完成以後導回原畫面
    redirect_to room_path(params[:room_id], :co_status => 5, interaction_id: params[:interaction_id], step: "pass")

  end

end
