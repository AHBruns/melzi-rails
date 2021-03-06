class AuthController < ApplicationController
  layout "auth"
  skip_before_action :login_required, only: [
    :login,
    :authenticate,
    :register,
    :create,
  ]
  skip_before_action :email_verification_required, only: [
    :login,
    :authenticate,
    :register,
    :create,
  ]
  
  def login; end
  
  def register; end
  
  def authenticate
    possible_matches = User.where(email: params[:email])
    possible_matches = possible_matches.filter { |user| user.check_password(params[:password]) }
    
    if possible_matches.empty?
      session[:auth_fields] = {
        email: params[:email],
        password: params[:password]
      }
      flash[:error] = "Wrong email and/or password."
      redirect_to login_path
    elsif possible_matches.size > 1
      session[:auth_fields] = {
        email: params[:email],
        password: params[:password]
      }
      flash[:error] = "Melzi is currently experiencing an issue. Please try again later."
      logger.error "User collision detected during login. possible_matches: #{possible_matches}"
      redirect_to login_path
    else
      session.delete(:auth_fields)
      @user = possible_matches.first
      session[:user_id] = @user.id
      redirect_to works_path
    end
  end
  
  def deauthenticate
    session.delete(:user_id)
    redirect_to login_path
  end
  
  def create
    @user = User.new(email: params[:email], password: params[:password])
    
    if @user.save
      GodMailer.with(user: @user).new_sign_up.deliver_later
      UserMailer.with(user: @user).verify_email.deliver_later
      session.delete(:auth_fields)
      session[:user_id] = @user.id
      redirect_to works_path
    else
      session[:auth_fields] = {
        email: params[:email],
        password: params[:password]
      }
      flash[:error] = "That email is already in use."
      redirect_to register_path
    end
  end
  
  private
    
    def user_params
      params.fetch(:user, {}).permit(:email, :password)
    end
end