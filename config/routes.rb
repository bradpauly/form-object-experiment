Rails.application.routes.draw do

  resources :registrations, only: [:index]
  resources :sessions, only: [:new, :create]

  post "register", to: "registrations#create", as: "register"
  match '/register', to: 'registrations#new', via: [:get]

  post "login", to: "sessions#create", as: "login"
  match '/login', to: 'sessions#new', via: [:get]

  get "/logout", to: "sessions#destroy", as: "logout"
end
