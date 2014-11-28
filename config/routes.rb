Rails.application.routes.draw do
  root "posts#index"

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :posts, except: [:destroy]
  resources :users, only: [:show, :create, :edit, :update, :index] do
    member do
      post 'befriend'
      post 'unfriend'    
    end
    resources :friendships, only: [:create, :destroy]  
  end
  resources :feelings, only: [:new, :create, :show]

end
