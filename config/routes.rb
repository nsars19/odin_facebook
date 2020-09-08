Rails.application.routes.draw do
  devise_for :users
  root 'posts#index', as: 'home'

  resources :users, only: [:index, :show]
  resources :notifications, only: :index
  resources :posts, only: [:create, :index] do
    resource :like, only: [:new, :create, :destroy]
  end
end
