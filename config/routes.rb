Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}

  authenticated :user do
    root to: 'posts#index', as: :authenticated_root
  end
  root to: redirect('/users/sign_in')

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

  resources :chats, only: %i[index show new create] do
    get :close, on: :collection
    get :mark_read, on: :member
    resources :messages, only: %i[create]
  end

  resources :gifs, only: :index
  resources :users, only: %i[index show]
  resources :profile, only: %i[edit update]
  resources :friendships, only: %i[index create update destroy]

  get 'post_notification/:id', to: 'posts#post_via_notification', as: 'via_notification'
  get 'cancel_search', to: 'users#cancel_search'
end
