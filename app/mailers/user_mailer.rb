class UserMailer < ApplicationMailer
  default from: 'Melzi <notifications@melzi.io>'

  def verify_email
    @user  = params[:user]
    @token = SecureRandom.hex
    @user.email_verification_tokens.create(token: @token)
    mail(from: 'Melzi <verify@melzi.io>', to: @user.email, subject: 'Verify your Melzi account.')
  end
end
