Rails.application.routes.draw do
  root 'posts#index', as: 'home'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :notifications, only: :index
  
  resources :users, only: [:index, :show] do
    resources :friendships
  end
  
  resources :posts, only: [:create, :index] do
    resources :comments
    resource :like, only: [:new, :create, :destroy]
  end
end
