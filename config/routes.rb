Rails.application.routes.draw do
  root 'posts#index'
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:index, :show]
  resources :friend_requests, only: [:create, :update, :destroy]
  resources :friendships, only: [:destroy]
  resources :posts do
    resources :likes, only: [:create, :update, :destroy]
    resources :comments, except: [:index, :show]
  end
  resources :comments do
    resources :comments, except: [:index, :show]
  end
  get 'user/edit_avatar', to: 'users#edit_avatar'
  delete 'user/destroy_avatar', to: 'users#destroy_avatar'
  resource :user, only: [:edit] do
    collection do
      patch 'update_password'
      patch 'update_avatar'
    end
  end
end
