Rails.application.routes.draw do
  devise_for :users

  root 'posts#index'

  resources :posts do
    resources :comments, only: %i[create update destroy], module: :posts
  end

  resources :friendships, only: %i[index create update destroy]
  resources :users, only: %i[index show]
end
