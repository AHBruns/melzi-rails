class ApplicationController < ActionController::Base
  add_flash_types :success, :error
  before_action :set_current_user, :login_required, :email_verification_required

  private

  def set_current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    session[:user_id].present?
  end

  def email_verified?
    @current_user.email_verified
  end

  def login_required
    redirect_to login_path, flash: { error: "You must be logged in to do that." } unless logged_in?
  end

  def email_verification_required
    redirect_to email_verification_required_path unless email_verified?
  end
end
