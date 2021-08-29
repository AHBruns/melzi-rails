class EmailTokensController < ApplicationController
  skip_before_action :login_required, :email_verification_required
  before_action :set_token
  
  def index
    if @token.present?
      session[:user_id] = @token.user.id
      session[:logged_in_via_email_token] = true
      session[:email_token_kind] = @token.kind
      @token.destroy!
      case @token.kind.to_sym
        when :email_verification
          redirect_to email_verification_complete_path
        when :password_reset
          redirect_to reset_password_path
        else
          raise "unhandled EmailToken.kind"
      end
    else
      # TODO
      render inline: "This link is either expired or has already been used."
    end
  end
  
  private
    
    def set_token
      @token = EmailToken.find_by_value(params[:value])
      p EmailToken.all
      p @token
    end
end
