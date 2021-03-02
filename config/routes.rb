Rails.application.routes.draw do
  get 'users/show'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :users, only: [:show, :edit, :update]
  resources :genres

  resources :movies do
    resources :reviews
  end
  root 'movies#index'
end
