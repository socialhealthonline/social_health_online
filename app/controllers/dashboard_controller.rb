class DashboardController < ApplicationController
  before_action :require_authentication

  def index
    @notifications = Notification.page(params[:page])
  end

end
