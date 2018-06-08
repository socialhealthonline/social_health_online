class ApplicationController < ActionController::Base
  helper_method :authenticated_user, :mailbox, :conversation
  add_flash_types :error, :success, :info, :warning

  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def cities
    render json: CS.cities(params[:state], :us).to_json
  end

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

  def mailbox
    @mailbox ||= authenticated_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  def render_404(message = 'Not Found')
    logger.info "Rendering 404: #{message}"
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

end
