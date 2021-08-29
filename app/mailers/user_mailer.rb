class UserMailer < ApplicationMailer
  default from: 'Melzi <notifications@melzi.io>'

  def verify_email
    @user  = params[:user]
    @token = @user.email_tokens.create!(kind: :email_verification)
    mail(from: 'Melzi <verify@melzi.io>', to: @user.email, subject: 'Verify your Melzi account.')
  end
  
  def reset_password
    @user  = params[:user]
    @token = @user.email_tokens.create!(kind: :password_reset)
    mail(from: 'Melzi <forgot-password@melzi.io>', to: @user.email, subject: "Reset your Melzi account's password.")
  end
end
