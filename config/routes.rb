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
  devise_for :users
  root "home#index"
  resources :posts
  resources :profile , only: [:index]
  resources :about , only: [:index]


  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"

end
