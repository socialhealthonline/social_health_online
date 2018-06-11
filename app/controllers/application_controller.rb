class ApplicationController < ActionController::Base
  helper_method :authenticated_user, :mailbox, :conversation
  add_flash_types :error, :success, :info, :warning
  before_action :disabled_user?
  before_action :pending_user?

  def cities
    render json: CS.cities(params[:state], :us).to_json
  end

  private

  def authenticated_user
    @authenticated_user ||= User.find_by(auth_token: session[:auth_token]) if session[:auth_token]
  end

  def disabled_user?
    if authenticated_user&.disabled?
      session[:auth_token] = nil
    end
  end
  
  def pending_user?
    if authenticated_user&.pending?
      redirect_to profile_url, warning: 'You should first complete you profile!'
    end
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

  def mailbox
    @mailbox ||= authenticated_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

end
