Rails.application.routes.draw do
  get "account/switch"
  post "account/set_current", as: :account_set_current
  root "users#index"

  get "up", to: "rails/health#show", as: :rails_health_check

  resource :session, only: [ :new, :create, :destroy ]
  resources :passwords, param: :token, only: [ :new, :create, :edit, :update ]
  resources :invitations, only: [ :new, :create, :edit, :update ], param: :token

  get "registration", to: "registrations#new", as: :new_registration
  post "registration", to: "registrations#create"
  delete "logout", to: "sessions#destroy", as: :logout

  resources :users, only: [ :index ]
end
