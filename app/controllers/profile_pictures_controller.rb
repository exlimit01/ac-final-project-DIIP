class ProfilePicturesController < ApplicationController
  
  def index
    
  @avatars = Avatar.all

  end



  def create
      
    @user_info = ProfilePicture.find_by(user_id: current_user.id)

    if @user_info.nil?
      ProfilePicture.create(
        avatar_id: params[:avatar_id],
        user_id: current_user.id      
      ) 
      flash[:notice] = 'Avatar updated.'
      redirect_to edit_profile_path(current_user.profile.id)   
    else

      @user_info.update(
        avatar_id: params[:avatar_id],
        user_id: current_user.id   
        )
      redirect_to edit_profile_path(current_user.profile.id)  
    end               
  end


end
