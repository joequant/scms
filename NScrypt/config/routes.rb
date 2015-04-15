Rails.application.routes.draw do

  resources :rights

  resources :debug_runs

  as :user do
      match '/user/confirmation' => 'confirmations#update', :via => :patch, :as => :update_user_confirmation
  end
  devise_for :users, :controllers => { :confirmations => "confirmations" }

  resources :contacts

  resources :wallets

  get 'marketplace/index'

  resources :notes

  resources :minutes

  resources :templates

  resources :wallets

  resources :sc_values

  resources :sc_event_runs

#  get 'sessions/new'

#  get "log_out" => "sessions#destroy", :as => "log_out"
#  get "log_in" => "sessions#new", :as => "log_in"
#  get "sign_up" => "users#new", :as => "sign_up"

  root :to => "contracts#index"

#  resources :sessions

  resources :parties  do
    patch :assign
    patch :unassign
    get :sign
    get :unsign
  end

  resources :roles

  resources :marketplace

  resources :sc_events do
    resources :schedules
    get :trigger
  end

  resources :codes do
    resources :sc_events
    resources :parties
    get :propose
    get :retract
    get :post
    get :unpost
    get :duplicate
    get :update_state
    get :reject
    get :accept
    get :debug
    post :debug_run
  end

  resources :contracts do
    resources :codes
  end

  resources :users do
    resources :parties
  end

  resources :schedules

end
