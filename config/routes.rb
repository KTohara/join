Rails.application.routes.draw do
  devise_for :users

  root 'posts#index'

  resources :posts, except: [:new] do
    resources :comments, only: %i[create], module: :posts
  end
  
  resources :comments, only: %i[edit update destroy] do
    resources :comments, only: %i[create], module: :comments
  end

  resources :friendships, only: %i[index create update destroy]
  resources :users, only: %i[index show]
end
