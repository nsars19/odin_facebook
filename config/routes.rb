Rails.application.routes.draw do
  devise_for :users
  root 'posts#index', as: 'home'

  resources :notifications, only: :index
  
  resources :users, only: [:index, :show] do
    resources :friendships
  end
  
  resources :posts, only: [:create, :index] do
    resources :comments
    resource :like, only: [:new, :create, :destroy]
  end

  post 'accept_friend_request', to: 'friendships#accept_friend_request', as: 'accept_request'
end
