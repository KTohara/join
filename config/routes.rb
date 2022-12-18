Rails.application.routes.draw do
  devise_for :users

  root 'posts#index'

  resources :posts, except: %i[new edit]
  resources :friendships, only: %i[create destroy]
  resources :users, only: %i[index show]
end
