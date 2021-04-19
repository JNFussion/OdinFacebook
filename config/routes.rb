Rails.application.routes.draw do
  root 'posts#index'
  
  devise_for :users
  resources :users, only: [:index, :show]
  resources :posts
  resources :friend_requests, only: [:create, :update, :destroy]
  resources :friendships, only: [:destroy]
end
