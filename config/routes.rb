Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}

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

  resources :notifications, only: %i[index destroy] do
    delete :clear_all, on: :collection
  end

  resources :chats, only: %i[index show] do


    resources :messages, only: %i[create]
  end

  resources :gifs, only: :index
  resources :users, only: %i[index show]
  resources :profile, only: %i[edit update]
  resources :friendships, only: %i[index create update destroy]

  get 'chat/:id/mark_read', to: 'chats#mark_read', as: 'chat_mark_read'
  get 'chat/:id/close', to: 'chats#close', as: 'chat_close'
  get 'post_notification/:id', to: 'posts#post_via_notification', as: 'via_notification'
  get 'cancel_search', to: 'users#cancel_search'
end
