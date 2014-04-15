class SessionsController < ApplicationController

  before_action :current_session, only: [:create, :destroy]
  before_action :set_channel, only: [:create, :destroy]
  skip_before_action :sign_in, only: [:new, :create]

  def new  
  end  
  
  def create  
    binding.pry
    user = User.find_by_email(params[:email])  
    if user && user.authenticate(params[:password])  
      session[:user_id] = user.id  
      redirect_to root_url, :notice => "Logged in!"  
    else  
      flash.now.alert = "Invalid email or password"  
      render "new"  
    end  
  end    
  
  def destroy  
    session[:user_id] = nil  
    redirect_to root_url, :notice => "Logged out!"  
  end

  private
  def current_session
    @session = Session.find_by_session_id(session.id)
  end

  def set_channel
    @channel = Channel.new name: "online-users"
  end
end
