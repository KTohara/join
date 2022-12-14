Rails.application.routes.draw do
  devise_for :users

  root 'posts#index'

  resources :posts, except: :new do
    resources :likes, only: %i[create destroy], module: :posts
    resources :comments, only: %i[create], module: :posts
  end
  
  resources :comments, only: %i[edit update destroy] do
    resources :likes, only: %i[create destroy], module: :comments
    resources :comments, only: %i[create], module: :comments
  end

  resources :notifications, only: :destroy do
    delete :clear_all, on: :collection
    get :read, on: :collection
    get :unread, on: :collection
  end

  resources :users, only: %i[index show] do
    post :show, on: :member
  end

  resources :friendships, only: %i[index create update destroy]
end
