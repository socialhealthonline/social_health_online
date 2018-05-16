class DashboardController < ApplicationController
  before_action :require_authentication

  def index
    @notifications = Notification.page(params[:page])
    @events = Event.joins(:rsvps).where("rsvps.user_id = ? and rsvps.rsvp_status in (?) and start_at >= ?",
                                        authenticated_user.id, ['Maybe', 'Yes'], Time.use_zone('UTC') { Time.zone.now })
                                        .select('events.*, rsvps.rsvp_status as status')
  end
end
