class HomeController < ApplicationController
  before_action :require_authentication
  helper_method :sort_column, :sort_direction

  def index
    @notifications = Notification.order('updated_at desc').page(params[:page])
    @events = Event.order("#{sort_column} #{sort_direction}").page(params[:page])
    @events = Event.joins(:rsvps).events_for_feed(authenticated_user.id)
    @social_event_Logs = SocialEventLog.where(user_id: authenticated_user.id)

    next_level = 10
    level = @social_event_Logs.size / next_level
    @level = level.floor
    @progress = (@social_event_Logs.size.modulo(next_level).round(2)) * next_level
  end

  private

    def set_event
      @events = Events.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :event_type)
    end

    def sort_column
      %w[title event_type start_at home_events_status].include?(params[:column]) ? params[:column] : 'title'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
    end
end
