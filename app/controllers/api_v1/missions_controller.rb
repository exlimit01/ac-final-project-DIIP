class ApiV1::MissionsController < ApiController

  before_action :authenticate_user!

  def index
    @missions = Mission.all
  end

  def show
    @mission = Mission.find(params[:id])
  end

end
