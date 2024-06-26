Rails.application.routes.draw do
  resources :carts
  get 'sessions/create'
  get 'sessions/destroy'
  get 'sessions/new'
  resources :reviews
  resources :transactions
  resources :admins
  resources :users
  resources :books
  resources :sessions, only: [:new,:create,:destroy] 
  
  root 'home#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  get 'signup', to: "users#new", as:'signup'
  get 'login', to: "sessions#new", as:'login'
  get 'logout', to: "sessions#destroy", as:'logout'
end
