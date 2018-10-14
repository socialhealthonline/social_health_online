class HomeController < ApplicationController
  before_action :require_authentication
  helper_method :sort_column, :sort_direction

  def index
    @notifications = Notification.order(created_at: :desc).page(params[:page]).per(10)
    @events = Event.joins(:rsvps).events_for_feed(authenticated_user.id).order("#{sort_column} #{sort_direction}").page(params[:event_page]).per(5)
    @social_event_Logs = SocialEventLog.where(user_id: authenticated_user.id)

    next_level = 10
    level = @social_event_Logs.size / next_level
    @level = level.floor
    @progress = (@social_event_Logs.size.modulo(next_level).round(2)) * next_level

  end

  private

  def sortable_columns
    %w[
      title start_at status
    ]
  end

  def sort_column
    logger.debug("SORT:::: #{params[:direction].inspect}")
    sortable_columns.include?(params[:column]) ? params[:column] : 'title'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
