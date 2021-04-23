Rails.application.routes.draw do
  root 'posts#index'
  
  devise_for :users
  resources :users, only: [:index, :show]
  resources :friend_requests, only: [:create, :update, :destroy]
  resources :friendships, only: [:destroy]
  resources :posts do
    resources :likes, only: [:create, :update, :destroy]
  end
  
  
end
