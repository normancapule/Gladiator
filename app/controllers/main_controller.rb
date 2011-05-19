class MainController < ApplicationController
  before_filter :log_in?
  before_filter :session_expiry
  before_filter :update_activity_time

  def log_in?
    if login_checker == false
      redirect_to log_in_path
    end
  end

  def index
    puts "---------REQUEST----------------------"
    puts request.host
    puts request.domain(n=2)
    puts request.method
    puts request.get?
    puts request.post?
    puts request.put?
    puts request.delete?
    puts request.head?
    puts request.port
    puts request.protocol
    puts request.query_string
    puts request.remote_ip
    puts request.url
    puts "---------------------------------------"
    @logged_name = user_name
    @fight_history = Fight.all
    @list = Gladiator.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @list}
    end
  end

  def fight
    fighter1 = Gladiator.find(session[:fighter1]) rescue ActiveRecord::RecordNotFound
    fighter2 = Gladiator.find(session[:fighter2]) rescue ActiveRecord::RecordNotFound
    while fighter1.hitpoints>0 || fighter2.hitpoints>0
      fighter1.hitpoints -= fighter2.damage + (fighter2.strength * fighter2.agility/100 * rand(fighter2.intelligence-1))
      fighter2.hitpoints -= fighter1.damage + (fighter1.strength * fighter1.agility/100* rand(fighter2.intelligence-1))
    end
    if(fighter1.hitpoints>0)
      fighter1.win+=1
      fighter2.loss+=1
      temp_fight = Fight.create
      temp_fight.winner_id = fighter1.id
      temp_fight.losser_id = fighter2.id
      temp_fight.save
      flash[:fight_out] = %Q{#{fighter1.name} Wins!!!}
    else
      fighter1.loss+=1
      fighter2.win+=1
      temp_fight = Fight.create
      temp_fight.winner_id = fighter2.id
      temp_fight.losser_id = fighter1.id
      temp_fight.save
      flash[:fight_out] = %Q{#{fighter2.name} Wins!!!}
    end
    fighter1.hitpoints = 100
    fighter2.hitpoints = 100
    fighter1.save
    fighter2.save
    redirect_to "/main"
  end

  def random 
      db_size = Gladiator.last.id

      session[:fighter1] = 0
      session[:fighter2] = 0

        while(Gladiator.exists?(session[:fighter1])==false || session[:fighter1] == session[:fighter2] || session[:fighter1]==0)
          session[:fighter1] = rand((db_size))
        end
        while(Gladiator.exists?(session[:fighter2])==false || session[:fighter1]==session[:fighter2] || session[:fighter2]==0)
          session[:fighter2] = rand((db_size))
        end
    redirect_to "/main"
  end

  def clear_history
    Fight.delete_all
    redirect_to "/main"  
  end

end
