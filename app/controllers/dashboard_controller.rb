class DashboardController < ApplicationController
  before_action :require_authentication

  def index
    @notifications = Notification.page(params[:page])
    @events = Event.joins(:rsvps).events_for_feed(authenticated_user.id)

    next_level = 10
    level = @events.size / next_level
    @level = level.floor
    @progress = (@events.size.modulo(next_level).round(2)) * next_level
  end
end
