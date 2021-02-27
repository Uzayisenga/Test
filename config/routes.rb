Rails.application.routes.draw do
  devise_for :users
  resources :movies do
    resources :reviews
    #collection do
    #  post :confirm
  #  end
  end
  root 'movies#index'
end
