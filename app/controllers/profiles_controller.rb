class ProfilesController < ApplicationController

  before_action :set_profile, :only => [:show, :edit, :update, :destroy]
  before_action :set_friendship, :only => [:show]

  # GET /profiles
  def index
    @profiles = Profile.all
  end

  # GET /profiles/:id
  def show
    if params[:aid]
      @answer = Answer.find(params[:aid])
    else
      @answer = Answer.new
    end
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  #POST /profiles
  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    @profile.save

    if params[:photos]
      params[:photos].each do |photo|
        @profile.photos.create(:photo => photo)
      end
    end
    redirect_to profile_path(@profile)
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
      redirect_to profile_path(@profile)
    end

  end

  #DELETE /profiles/:id
  def destroy
    @profile.destroy
    redirect_to profile_path(@profile)
  end

  # GET /profiles/entrance
  def entrance
    if current_user
      redirect_to empty_profiles_path
    else
      redirect_to new_session_path(:user)
    end
  end

  def empty
    if current_user.profile
      redirect_to profile_path(current_user.profile.id)
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def set_friendship

    if current_user.id != params[:id].to_i
      # 檢查是否有建立過好友 沒有的話就建立
      friendships = current_user.friendships.where(friend_id: params[:id])
      if friendships.count == 0
        friendship = Friendship.create(user_id: current_user.id, friend_id: params[:id], status: "none", :love_level => 0 )
      end

      # 對方跟你沒建過關係的話 建立一筆反向的無的關係
      inverse_friendships = Friendship.where(:user_id => params[:id], :friend_id => current_user.id)
      if inverse_friendships.count == 0
        Friendship.create(user_id: params[:id], friend_id: current_user.id, status: "none", :love_level => 0 )
      end

      @friendship = Friendship.find_by(user_id: current_user.id, friend_id: params[:id])
      @inverse_frienship = Friendship.find_by(user_id: params[:id], friend_id: current_user.id)
    else

      @friendship = nil
    end



  end

  def profile_params
    params.require(:profile).permit(:nickname, :age, :avatar, :photos, :description, :facebook_link,
      :facebook_access_level ,:line_account, :line_access_level, :wechat_account, :wechat_access_level, :location_id,
      :sex, :relation, :aboutme, :hobby_ids => [], :profession_ids => [])
  end


end