Rails.application.routes.draw do
  root to: "users#index"
  get "up" => "rails/health#show", as: :rails_health_check
  resource :session
  resources :passwords, param: :token, only: [:new, :create, :edit, :update]
  get "/registration", to: "registrations#new", as: :new_registration
  post "/registration", to: "registrations#create"
  resources :invitations, only: [:new, :create]
  get "/invitations/accept", to: "invitations#edit", as: :edit_invitation
  patch "/invitations/accept/:token", to: "invitations#update", as: :update_invitation
  delete "/logout", to: "sessions#destroy", as: :logout
  resources :users, only: [:index]
end
