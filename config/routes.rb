Rails.application.routes.draw do
  root "sessions#home"
  
  #sign up route
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  #login route
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'

  #logout route
  delete '/logout' => 'sessions#destroy'

  #omniauth callback
  get "/auth/google_oauth2/callback" => 'sessions#google'

  resources :users do
    resources :lists, only: [:new,:create,:index]
  end
  resources :lists do
    resources :comments, only: [:new,:create,:index]
  end
  resources :movies
  resources :comments
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end