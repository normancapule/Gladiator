class CreateFighterController < ApplicationController
  before_filter :log_in?
  before_filter :session_expiry
  before_filter :update_activity_time

  def log_in?
    if login_checker == false
      redirect_to log_in_path
    end
  end

  def index
    @gladiator = Gladiator.new
  end

  def edit
    @gladiator = Gladiator.find(params[:id])
  end

  def create
    @gladiator = Gladiator.new(params[:gladiator])
    if @gladiator.save
      redirect_to main_path
    else
      flash[:error] = @gladiator.errors.to_s  
      render 'index'
    end
    puts "-----------RESPONSE-------------------"
    puts response.body
    puts response.status
    puts response.location
    puts response.content_type
    puts response.charset
    puts response.headers
    puts "--------------------------------------"
  end

  def update
    @gladiator = Gladiator.find(params[:id])
    if @gladiator.update_attributes(params[:gladiator])
      redirect_to main_path
    else
      flash[:error] = @gladiator.errors.to_s  
      render 'edit'
    end
    puts "-----------RESPONSE-------------------"
    puts response.body
    puts response.status
    puts response.location
    puts response.content_type
    puts response.charset
    puts response.headers
    puts "--------------------------------------"
  end

  def destroy
    Gladiator.destroy(params[:id])
    temp_destroy_history = Fight.where("winner_id=? OR losser_id=?", params[:id], params[:id])
    temp_destroy_history.each do |temp|    
     Fight.destroy(temp)
    end
    redirect_to "/main"
    puts "-----------RESPONSE-------------------"
    puts response.body
    puts response.status
    puts response.location
    puts response.content_type
    puts response.charset
    puts response.headers
    puts "--------------------------------------"
  end
end
