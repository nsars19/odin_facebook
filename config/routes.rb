Rails.application.routes.draw do
  devise_for :users
  root 'users#index', as: 'home'

  resources :users, only: [:index, :show]
end
