RorGladiator::Application.routes.draw do

  root :to => "sessions#new"
  get "log_in" => "sessions#new", :as => "log_in"  
  get "log_out" => "sessions#destroy", :as => "log_out"  
  get "sign_up" => "users#new", :as => "sign_up"    
  resources :users, :only =>[:new, :create]
  resources :sessions, :only =>[:new, :create, :destroy]
  match "main" => "main#index", :via => :get
  match "main/random" => "main#random", :via => :post
  match "main/fight" => "main#fight", :via => :post
  match "main/clear_history" => "main#clear_history"

  #match "create_fighter/edit/:id" => "create_fighter#edit", :via => :get  
  #match "create_fighter/edit/:id" => "create_fighter#update", :via => :post 
  #match "create_fighter/delete/:id" => "create_fighter#delete", :via => :get  
  #match "create_fighter" => "create_fighter#index", :via => :get
  #match "create_fighter" => "create_fighter#create", :via => :post
  resources "create_fighter" , :except => [ :show]

end
