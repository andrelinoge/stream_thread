class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception

  before_filter :sign_in, :online_users

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  private
  def sign_in
    redirect_to new_session_path, notice: 'Please login to access this page.' unless current_user
  end

  def online_users
    @online_users = Session.online_users
  end
end
