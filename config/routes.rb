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
  get "/profiles/unauthenticate", to: "profiles#unauthenticate"
  post "/profiles/authenticate", to: "profiles#authenticate"
  post "/profiles/create", to: "profiles#create"
  get "/email-verification-required", to: "profiles#verify_email"
  get "/email-verification-required/:token", to: "profiles#verify_email"
  get "/send-verification-email", to: "profiles#send_verification_email"
end
