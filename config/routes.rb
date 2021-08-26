Rails.application.routes.draw do
  get 'search/search'
  resources :licenses, :contracts, :submissions, :buyers, :works

  resources :users do
    member do
      get :assume
    end

    collection do
      get :unassume
    end
  end

  get "/search/results", to: "search#results"

  get "/", to: "profiles#login"
  get "/login", to: "profiles#login"
  get "/register", to: "profiles#register"
  get "/email-verification-required", to: "profiles#verify_email"
  get "/forgot-password", to: "profiles#forgot_password"
  get "/reset-password", to: "profiles#reset_password"

  # TODO: make this a POST
  get "/profiles/unauthenticate", to: "profiles#unauthenticate"
  post "/profiles/authenticate", to: "profiles#authenticate"
  post "/profiles/create", to: "profiles#create"

  post "/profiles/send-forgot-password-email", to: "profiles#send_forgot_password_email"
  # TODO: make this a POST
  get "/profiles/send-verification-email", to: "profiles#send_verification_email"

  get "/email-verification-complete", to: "profiles#email_verification_complete"
  get "/password-reset-complete", to: "profiles#password_reset_complete"
end
