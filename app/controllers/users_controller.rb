class UsersController < ApplicationController
  skip_before_filter :session_expiry
  skip_before_filter :update_activity_time

  def new  
    @user = User.new  
  end  
    
  def create  
    @user = User.new(params[:user])  
    if @user.save  
      redirect_to log_in_url, :notice => "Signed up!"  
    else  
      render "new"  
    end  
  end  
end
