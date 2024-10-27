Rails.application.routes.draw do
  root "home#index"

  resources :boards
  resources :tasks
  resources :comments
  resources :invitations

  devise_for :users,
    path: "auth",
    path_names: {
      sign_in: "login",
      sign_out: "logout",
      confirmation: "verification",
      sign_up: "signup",
    },
    controllers: {
      registrations: "users/registrations"
    }

  get "up" => "rails/health#show", as: :rails_health_check
end
