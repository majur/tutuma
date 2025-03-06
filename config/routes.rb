Rails.application.routes.draw do
  root "users#index"

  get "up", to: "rails/health#show", as: :rails_health_check

  resource :session, only: [ :new, :create, :destroy ]
  resources :passwords, param: :token, only: [ :new, :create, :edit, :update ]
  get 'invitations/:token/edit', to: 'invitations#edit', as: :edit_invitation
  patch 'invitations/:token', to: 'invitations#update', as: :update_invitation
  resources :invitations, only: [:new, :create]

  get "registration", to: "registrations#new", as: :new_registration
  post "registration", to: "registrations#create"
  delete "logout", to: "sessions#destroy", as: :logout

  resources :users, only: [ :index ]
end
