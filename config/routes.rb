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

  resources :notifications, only: [:index, :destroy] do
    delete :clear_all, on: :collection
  end

  get 'post_notification/:id', to: 'posts#post_via_notification', as: 'via_notification'
  get 'cancel_search', to: 'users#cancel_search'

  resources :users, only: %i[index show edit]
  resources :profile, only: %i[edit update]
  resources :friendships, only: %i[index create update destroy]
end
