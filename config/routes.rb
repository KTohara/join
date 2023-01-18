Rails.application.routes.draw do
  devise_for :users

  root 'posts#index'

  resources :posts, except: :new do
    scope module: :posts do
      resources :likes, only: %i[create destroy]
      resources :comments, only: :create
      post 'show_comments', to: 'comments#show_comments'
    end
  end
  
  resources :comments, only: %i[show edit update destroy] do
    scope module: :comments do
      resources :likes, only: %i[create destroy]
      resources :comments, only: :create
      post 'show_comments', to: 'comments#show_comments'
    end
  end

  resources :notifications, only: :destroy do
    delete :clear_all, on: :collection
    get :read, on: :collection
    get :unread, on: :collection
  end

  resources :users, only: %i[index show]
  resources :friendships, only: %i[index create update destroy]
end
