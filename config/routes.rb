Rails.application.routes.draw do
  root to: 'home#index'
  resources :publications, only: [:new, :create, :show]
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :profiles, only: %i[update show]
  post 'edit_profile', to: 'profiles#edit'
end
