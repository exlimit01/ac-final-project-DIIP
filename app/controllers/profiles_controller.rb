class ProfilesController < ApplicationController

  before_action :set_profile, :only => [:show, :edit, :update, :destroy]

  # GET /profiles
  def index
    @profiles = Profile.all
  end

  # GET /profiles/:id
  def show

  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  #POST /profiles
  def create
    @profile = Profile.new(profile_params)
    @profile.save

    if params[:photos]
      params[:photos].each do |photo|
        @profile.photos.create(:photo => photo)
      end
    end
    redirect_to profiles_path
  end

  #GET /profiles/:id/edit
  def edit

  end

  #PATCH /profiles/:id
  def update

    if params[:_remove_avatar] == "1"
      @profile.avatar = nil
    end

    if params[:_remove_photos] == "1"
      @profile.photos.destroy_all
    end

    if @profile.update(profile_params)

      if params[:photos]
        params[:photos].each do |photo|
          @profile.photos.create(:photo => photo)
        end
      end

      redirect_to profiles_path

    end

  end

  #DELETE /profiles/:id
  def destroy
    @profile.destroy
    redirect_to profiles_path
  end

  # GET /profiles/entrance
  def entrance
    if current_user
      redirect_to profiles_path
    else
      redirect_to new_session_path(:user)
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:nickname, :age, :avatar, :photos, :description, :facebook_link,
      :facebook_access_level ,:line_account, :line_access_level, :wechat_account, :wechat_access_level, :location_id)
  end


end