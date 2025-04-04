Rails.application.routes.draw do
  # get "profile/index"
  # get "category/index"
  # get "post/index"
  devise_for :users
  root "home#index"
  resources :posts
  resources :category
  resources :profile , only: [:index]
end
