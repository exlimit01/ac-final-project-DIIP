class ApiV1::MissionsController < ApiController

  def index
    @missions = Mission.all
  end

  def show
    @mission = Mission.find(params[:id])
  end

end
