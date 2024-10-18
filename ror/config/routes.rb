Rails.application.routes.draw do
  root "rails/health#show"

  resources :boards
  resources :tasks
  resources :invitations

  devise_for :users,
    path: "auth",
    path_names: {
      sign_in: "login",
      sign_out: "logout",
      registration: "register",
      sign_up: "signup"
    },
    controllers: {
      registrations: "users/registrations"
    }

  get "up" => "rails/health#show", as: :rails_health_check
end
