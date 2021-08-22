class ProfilesController < ApplicationController
  layout "auth"
  skip_before_action :login_required,
                     :email_verification_required,
                     only: [:login, :authenticate, :register, :create, :verify_email, :send_verification_email]

  def login; end

  def register; end

  def verify_email
    if email_verified?
      redirect_to works_path
    elsif params[:token].present?
      user = EmailVerificationToken.find_by_token(params[:token]).user
      user.email_verified = true
      flash[:success] = "Your email is now verified."
      if user.save
        redirect_to works_path
        user.email_verification_tokens.destroy_all
      end
    end
  end

  def authenticate
    possible_matches = User.where(email: params[:email])
    possible_matches = possible_matches.filter { |user| user.check_password(params[:password]) }

    if possible_matches.empty?
      session[:auth_fields] = {
        email: params[:email],
        password: params[:password]
      }
      flash[:error] = "Wrong email and/or password."
      redirect_to :login
    elsif possible_matches.size > 1
      session[:auth_fields] = {
        email: params[:email],
        password: params[:password]
      }
      flash[:error] = "Melzi is currently experiencing an issue. Please try again later."
      logger.error "User collision detected during login. possible_matches: #{possible_matches}"
      redirect_to :login
    else
      session.delete(:auth_fields)
      @user = possible_matches.first
      session[:user_id] = @user.id
      redirect_to works_path
    end
  end

  def unauthenticate
    session.delete(:user_id)
    redirect_to :login
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
      redirect_to :register
    end
  end

  def send_verification_email
    UserMailer.with(user: @current_user).verify_email.deliver_later
    flash[:success] = "Another verification email has been sent."
    redirect_to action: :verify_email
  end

  private

  def user_params
    params.fetch(:user, {}).permit(:email, :password)
  end
end