Rails.application.routes.draw do
  devise_for :users
  root 'events#index'

  resources :users
  resources :events
end
