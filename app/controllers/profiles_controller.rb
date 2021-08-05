class ProfilesController < ApplicationController
  layout "auth"
  skip_before_action :require_current_user, only: [:login, :authenticate, :register, :create]

  def login
  end

  def register
  end

  def authenticate
    possible_users = User.where(email: params[:email])
    possible_users = possible_users.filter do |user|
        user.check_password params[:password]
    end
    if possible_users.empty?
      session[:auth_fields] = { email: params[:email], password: params[:password] }
      flash[:error] = "Wrong email and/or password."
      redirect_to controller: :profiles, action: :login
    else
      session.delete(:auth_fields)
      @user = possible_users.first
      session[:user_id] = @user.id
      redirect_to controller: :works, action: :index
    end
  end

  def unauthenticate
    session.delete(:user_id)
    redirect_to "/"
  end

  def create
    @user = User.new(email: params[:email], password: params[:password])
    if @user.save
      session.delete(:auth_fields)
      session[:user_id] = @user.id
      redirect_to controller: :works, action: :index
    else
      session[:auth_fields] = { email: params[:email], password: params[:password] }
      flash[:error] = "That email is already in use."
      redirect_to controller: :profiles, action: :register
    end
  end

  private
    def user_params
      params.fetch(:user, {}).permit(:email, :password)
    end
end