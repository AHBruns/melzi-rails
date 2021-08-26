class ProfilesController < ApplicationController
  layout "auth"
  skip_before_action :login_required, only: [
    :login,
    :authenticate,
    :register,
    :create,
    :email_verification_complete,
    :forgot_password,
    :send_forgot_password_email,
    :reset_password,
    :password_reset_complete
  ]
  skip_before_action :email_verification_required, only: [
    :login,
    :authenticate,
    :register,
    :create,
    :verify_email,
    :send_verification_email,
    :email_verification_complete,
    :forgot_password,
    :send_forgot_password_email,
    :reset_password,
    :password_reset_complete
  ]

  def login; end

  def register; end

  def forgot_password; end

  def reset_password
    token = PasswordResetToken.find_by_token(params[:token])

    unless token
      flash[:error] = "That password reset link is no longer valid. Please try again."
      redirect_to action: :forgot_password
      return
    end

    @token = token.token
  end

  def verify_email; end

  def email_verification_complete
    redirect_to works_path if email_verified?

    token = EmailVerificationToken.find_by_token(params[:token])

    unless token
      flash[:error] = "Email verification failed. Please try again."
      redirect_to action: :verify_email
      return
    end

    user = token.user
    user.email_verified = true
    user.email_verification_tokens.destroy_all

    if user.save
      flash[:success] = "Your email is now verified."
      redirect_to (if logged_in?
                     works_path
                   else
                     login_path
                   end)
    else
      flash[:error] = "Email verification failed. Please try again."
      redirect_to action: :verify_email
    end
  end

  def password_reset_complete
    unless params[:new_password] == params[:confirm_new_password]
      flash[:error] = "Those passwords don't match."
      redirect_to action: :reset_password, token: params[:token]
      return
    end

    token = PasswordResetToken.find_by_token(params[:token])

    unless token
      flash[:error] = "Password reset failed. Please try again."
      redirect_to action: :forgot_password
      return
    end

    user = token.user
    user.password = params[:new_password]
    user.populate_salted_password_hash
    user.password_reset_tokens.destroy_all

    if user.save
      flash[:success] = "Your password was changed. Please login."
      redirect_to login_path
    else
      flash[:error] = "Password reset failed. Please try again."
      redirect_to action: :forgot_password
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

  def send_forgot_password_email
    user = User.find_by_email(params[:email])
    UserMailer.with(user: user).reset_password.deliver_later if user.present?
    flash[:success] = "If there is an account associated with the provided email, we'll send you a link which you can follow to reset your password."
    redirect_to action: :forgot_password
  end

  private

  def user_params
    params.fetch(:user, {}).permit(:email, :password)
  end
end