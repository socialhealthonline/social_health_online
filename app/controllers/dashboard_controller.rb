class DashboardController < ApplicationController
  before_action :require_authentication

  def index
    @notifications = Notification.page(params[:page])
    @events = Event.joins(:rsvps).events_for_feed(authenticated_user.id)
  end
end
