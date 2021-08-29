Rails.application.routes.draw do
  root to: "auth#login"
  
  # meat and potatoes
  resources :licenses, :contracts, :submissions, :buyers, :works
  
  # email tokens
  get 'melzi/:value', to: 'email_tokens#index', as: 'email_token'
  
  # email verification
  get 'email_verification/required'
  get 'email_verification/complete'
  post 'email_verification/send_email', as: 'send_email_verification_email'
  
  # password recovery
  get 'forgot-password', to: 'password_recovery#index', as: 'forgot_password'
  get 'reset_password', to: 'password_recovery#reset_password', as: 'reset_password'
  post 'password_recovery/send_email', as: 'send_password_recovery_email'
  post 'password_recovery/complete'
  
  # search
  get 'search', to: 'search#index'

  # auth
  get 'login', to: 'auth#login', as: 'login'
  get 'register', to: 'auth#register', as: 'register'
  # TODO: convert to POST
  get 'deauthenticate', to: 'auth#deauthenticate', as: 'deauthenticate'
  post 'authenticate', to: 'auth#authenticate', as: 'authenticate'
  post 'users/create', to: 'auth#create', as: 'create_user'
end
