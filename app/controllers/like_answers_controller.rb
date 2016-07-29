class LikeAnswersController < ApplicationController

  def like

    LikeAnswer.create!(friendship_id: params[:friendship_id], answer_id: params[:answer_id])
    f = Friendship.find(params[:friendship_id])
    before_love_level = f.love_level
    f.love_level += 5
    f.save
    after_love_level = f.love_level

    # 如果love_level跨越了10這個界限的話 系統給予任務
    if before_love_level < 10 && after_love_level >= 10

      user_id = f.user_id
      friend_id = f.friend_id
      inverse_friendship = Friendship.find_by(user_id: friend_id, friend_id: user_id)

      if inverse_friendship.love_level >= 10

        if f.interactions.count == 0 || f.interactions.last.co_status == 8

          m = Mission.all.sample
          f.interactions.create!(:mission_id => m.id, :co_status => 0)
          inverse_friendship.interactions.create!(:mission_id => m.id, :co_status => 0)

        elsif f.interactions.last.co_status < 5 && f.interactions.last.co_status >= -1

          m = Mission.all.sample
          f.interactions.last.update!(:mission_id => m.id, :co_status => 0)
          inverse_friendship.interactions.last.update!(:mission_id => m.id, :co_status => 0)

        end

      end

    end

    redirect_to profile_path(f.friend.profile)

  end

  def dislike
    redirect_to :back
  end

  protected

  def misssion_giving(frinedship)
    user = friendship.user




  end

end
