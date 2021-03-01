Rails.application.routes.draw do
  get 'users/show'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :users, only: [:show, :edit, :update]

  resources :movies do
    resources :reviews
    #collection do
    #  post :confirm
  #  end
  end
  root 'movies#index'
end
