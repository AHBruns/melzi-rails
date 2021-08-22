class GodMailer < ApplicationMailer
  default from: 'Melzi <notifications@melzi.io>'

  def new_sign_up
    @user  = params[:user]
    mail(to: 'God <alex.h.bruns@gmail.com>', subject: 'Melzi just signed up a new user!')
  end
end
