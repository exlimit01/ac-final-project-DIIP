class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    empty_profiles_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_session_path(:user)
  end

  #before_action :check_show_notification

  # 每次action前都會觸發，詢問是否跳出任務提醒視窗
  def check_show_notification

  end

end
