Rails.application.routes.draw do

  resources :contacts

  devise_for :users
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
  end

  resources :contracts do
    resources :codes
  end

  resources :users do
    resources :parties
  end

  #Add Human and Corporations
  resources :people, controller: 'users', type: 'Person'
  resources :corporations, controller: 'users', type: 'Corporation'
  
  resources :schedules
  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
