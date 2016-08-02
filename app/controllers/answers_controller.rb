class AnswersController < ApplicationController

  before_action :set_profile

  def create

    @answer = @profile.answers.new(answer_params)

    if @answer.save
      redirect_to profile_path(@profile)
    else
      render "profiles/show"
    end
  end

  def update
    @answer = @profile.answers.find(params[:id])
    if @answer.update(answer_params)
      redirect_to profile_path(@profile)
    else
      render "profiles/show"
    end
  end

  def destroy
    @answer = @profile.answers.find(params[:id])
    @answer.destroy
    redirect_to profile_path(@profile)
  end

  private

  def set_profile
    @profile = Profile.find(params[:profile_id])
  end

  def answer_params
    params.require(:answer).permit(:content, :question_id)
  end

end
