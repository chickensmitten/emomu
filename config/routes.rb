Rails.application.routes.draw do
  root "posts#index"

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'  

  resources :posts
  resources :users, only: [:show, :create, :edit, :update, :index] do
    member do
      post 'befriend'
      post 'unfriend'    
      get '/timeline', to: 'users#timeline'      
    end
    resources :friendships, only: [:create, :destroy, :index]  
  end
  resources :feelings, only: [:new, :create, :show, :index]
  resources :activities

end
