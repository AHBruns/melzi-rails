class PasswordRecoveryController < ApplicationController
  layout "empty"
  skip_before_action :login_required, only: [:index, :send_email]
  skip_before_action :email_verification_required
  
  def index; end
  
  def send_email
    user = User.where(email: params[:email]).first
    UserMailer.with(user: user).reset_password.deliver_later if user.present?
    redirect_to forgot_password_path, flash: { success: "Password reset email is being sent." }
  end
  
  def reset_password; end
  
  def complete
    return redirect_to forgot_password_path,
                       flash: {
                         error: "Password reset failed. Please try again."
                       } unless session[:logged_in_via_email_token] && session[:email_token_kind].to_sym == :password_reset
    
    return redirect_to reset_password_path,
                       flash: {
                         error: "The entered passwords don't match."
                       } unless params[:new_password] == params[:confirm_new_password]
    
    @current_user.password = params[:new_password]
    @current_user.populate_salted_password_hash
    if @current_user.save
      session.delete(:logged_in_via_email_token)
      session.delete(:email_token_kind)
      
      redirect_to works_path, flash: { success: "Password was successfully changed." }
    else
      redirect_to reset_password_path, flash: { error: "Password change failed. Please try again." }
    end
  end
end
