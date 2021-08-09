class ApplicationController < ActionController::Base
  before_action :set_current_user
  before_action :require_current_user

  private
    def set_current_user
      return unless session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end

    def logged_in?
      session[:user_id].present?
    end

    def require_current_user
      unless logged_in?
        flash[:error] = "You must be logged in to do that."
        redirect_to controller: :profiles, action: :login
      end
    end
end
