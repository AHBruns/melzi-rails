class ApplicationController < ActionController::Base
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
    unless logged_in?
      flash[:error] = 'You must be logged in to do that.'
      redirect_to login_path
    end
  end

  def email_verification_required
    unless email_verified?
      redirect_to '/email-verification-required'
    end
  end
end
