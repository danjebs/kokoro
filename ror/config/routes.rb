Rails.application.routes.draw do
  #

  devise_for :users,
    skip: [:sessions],
    controllers: {
      registrations: "users/registrations",
      sessions: "users/sessions",
      confirmations: "users/confirmations"
    }

  devise_scope :user do
    get "login", to: "devise/sessions#new", as: :new_user_session
    post "login", to: "devise/sessions#create", as: :user_session
    get "logout", to: "devise/sessions#destroy", as: :destroy_user_session
    get "welcome", to: "users/confirmations#welcome"
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
