class EmailVerificationController < ApplicationController
  layout "empty"
  skip_before_action :email_verification_required
  
  def required; end

  def send_email
    UserMailer.with(user: @current_user).verify_email.deliver_later
    redirect_to email_verification_required_path, flash: { success: "Verification email is being sent." }
  end
  
  def complete
    redirect_to works_path, flash: { error: "Email was already verified." } if @current_user.email_verified
    
    redirect_to email_verification_required_path,
                flash: {
                  error: "Email verification failed. Please try again."
                } unless session[:logged_in_via_email_token] && session[:email_token_kind].to_sym == :email_verification
    
    session.delete(:logged_in_via_email_token)
    session.delete(:email_token_kind)
    
    if @current_user.update(email_verified: true)
      redirect_to works_path, flash: { success: "Email was successfully verified." }
    else
      redirect_to email_verification_required_path,
                  flash: { error: "Email verification failed unexpectedly. Please try again." }
    end
  end
end
