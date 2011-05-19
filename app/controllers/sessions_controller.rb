class SessionsController < ApplicationController
  skip_before_filter :session_expiry
  skip_before_filter :update_activity_time

  def new  
  end  
    
  def create  
    user = User.authenticate(params[:username], params[:password])  
    if user  
      session[:user_id] = user.id  
      redirect_to main_path, :notice => "Logged in!"  
    else  
      flash.now.alert = "Invalid password"  
      render "new"  
    end  
  end 
  def destroy  
    session[:user_id] = nil  
    redirect_to log_in_url, :notice => "Logged out!"  
  end  
end
