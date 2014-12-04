Rails.application.routes.draw do
  root to: "users#landing"

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'  

  resources :posts do
    collection do
      post :search, to: "posts#search"
    end    
  end
  resources :users, only: [:show, :create, :edit, :update, :index] do
    member do
      post 'befriend'
      post 'unfriend'    
      get '/timeline', to: 'users#timeline'      
    end
    resources :friendships, only: [:create, :destroy, :index]  
    resources :user_feelings, only: [:index]
  end
  resources :feelings, only: [:new, :create, :show]
  resources :activities
  resources :password_resets

end
