Rails.application.routes.draw do
  devise_for :users
  root 'events#index'

  resources :users
  resources :events do
    resources :attendances
  end

  namespace :admin do
    root 'base#index'
    resources :users
  end
end
