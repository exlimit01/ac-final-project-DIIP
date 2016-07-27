class LikeAnswersController < ApplicationController

  def like

    LikeAnswer.create!(friendship_id: params[:friendship_id], answer_id: params[:answer_id])
    f = Friendship.find(params[:friendship_id])
    f.love_level += 5
    f.save
    redirect_to :back
  end

  def dislike
byebug
    #LikeAnswer.create!(friendship_id:, answer_id:)

    redirect_to :back
  end

end
