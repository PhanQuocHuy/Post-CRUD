Rails.application.routes.draw do
  resources :posts
  get "dashboard", to: "dashboard#index"

  get '/signup', to: 'users#new'
  post '/users', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  root 'sessions#new'
end