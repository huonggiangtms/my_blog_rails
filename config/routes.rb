Rails.application.routes.draw do
  # admin
  namespace :admin do
    root to: 'home#index'
    resources :posts do
      member do
      post 'report' 
      end
    end
    resources :categories
    resources :users
  end

  #user
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  root "home#index"
  resources :posts do
  resources :comments, only: [:create]
  end
  resources :profile , only: [:index]
  resources :about , only: [:index]


  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"

end
