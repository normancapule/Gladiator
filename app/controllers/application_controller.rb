class ApplicationController < ActionController::Base
  protect_from_forgery

  def session_expiry
    update_activity_time if session[:expires_at]==nil
    @time_left = (session[:expires_at] - Time.now).to_i
    unless @time_left > 0
      reset_session
      redirect_to log_in_path
    end
  end

  def update_activity_time
    session[:expires_at] = 5.minutes.from_now
    puts "#{session}-----------------------------"
  end

protected
    def fighter_1
      Gladiator.find(session[:fighter1])
    end

    def fighter_2
      Gladiator.find(session[:fighter2])
    end

    def login_checker
      if session[:user_id] != nil
        true
      else
        false
      end
    end

    def user_name
      User.find(session[:user_id]).username
    end
end
