class ApplicationController < ActionController::Base

  include PublicActivity::StoreController
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
#so this current_user is not considered a controller action.

  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:error] = "Must be logged in to do that."
      redirect_to root_path
    end
  end

  def require_admin
    access_denied unless logged_in? and current_user.admin?
  end

  def access_denied
    flash[:error] = "You can't do that."
    redirect_to root_path
  end

end
