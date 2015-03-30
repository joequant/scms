class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :authorize_admin!

  private
  def authorize_admin!
    user_signed_in? && current_user.admin?
  end
end
