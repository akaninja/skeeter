Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :publications, only: [:new, :create, :show]
end
