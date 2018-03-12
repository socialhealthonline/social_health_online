class ApplicationController < ActionController::Base
  helper_method :authenticated_user
  add_flash_types :error, :success, :info, :warning

  private

  def authenticated_user
    @authenticated_user ||= User.find_by(auth_token: session[:auth_token]) if session[:auth_token]
  end

  def require_authentication
    unless authenticated_user
      session[:intended_destination] = params
      redirect_to signin_url, error: 'You must sign in to continue!'
    end
  end

  def require_admin
    if authenticated_user.blank? || !authenticated_user.admin?
      redirect_to root_url and return
    end
  end

  def require_manager
    if authenticated_user.blank? || !authenticated_user.manager?
      redirect_to root_url and return
    end
  end

end
