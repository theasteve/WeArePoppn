Rails.application.routes.draw do

  resources :users, only: [:create, :new, :show]
  resources :sessions, only: [:new, :create, :destroy]

  get '/logout' => "sessions#destroy"

end