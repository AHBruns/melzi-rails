Rails.application.routes.draw do
  resources :licenses, :contracts, :submissions, :buyers, :works

  resources :users do
    member do
      get :assume
    end

    collection do
      get :unassume
    end
  end

  get "/", to: "profiles#login"
  get "/login", to: "profiles#login"
  get "/register", to: "profiles#register"
  get "/profiles/unauthenticate", to: "profiles#unauthenticate"
  post "/profiles/authenticate", to: "profiles#authenticate"
  post "/profiles/create", to: "profiles#create"
  
end
