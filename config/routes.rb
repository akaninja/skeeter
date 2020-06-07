Rails.application.routes.draw do
  root to: 'home#index'
  resources :publications, only: [:new, :create, :show]
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :profiles, only: [:show] do
    member do
      post 'follow', to: 'profiles#follow'
    end
  end
  get 'edit_profile', to: 'profiles#edit'
  patch 'update_profile', to: 'profiles#update'
end
