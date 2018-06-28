class SocialTracker::EventsController < ApplicationController
  before_action :require_authentication

  def new
    if daily_events_logged >= 3
      flash.now[:error] = 'You can log a maximum of 3 events per day.'
    end

    @social_event_log = SocialEventLog.new
  end

  def create
    parameters = log_params.to_h
    categories = build_event_categories(parameters[:event_categories])

    @social_event_log = authenticated_user.social_event_logs.build(parameters.except(:event_categories))
    @social_event_log.event_categories = categories if categories

    if @social_event_log.save && daily_events_logged < 3

      redirect_to social_tracker_history_url, success: "The event was logged successfully!"
    elsif daily_events_logged >=3
      flash.now[:error] = 'Unsuccessfully logged event. You can log a maximum of 3 events per day.'
      render :new
    else
      flash.now[:error] = "Please correct the errors to continue."
      render :new
    end
  end

  def index
    @social_event_logs = authenticated_user.social_event_logs.page params[:page]
  end

  def show
    @log = authenticated_user.social_event_logs.find(params[:id])
  end

  private

  def daily_events_logged
    today = Date.today
    range = today..today.next_day

    today_social_event_logs = authenticated_user.social_event_logs.where(created_at: range)
    today_social_event_logs.count
  end

  def build_event_categories(categories)
    return if categories.empty?
    categories.map { |category_name| EventCategory.new(name: category_name) }
  end

  def log_params
    params[:social_event_log][:event_types] ||= []
    params[:social_event_log][:event_categories] ||= []

    params.require(:social_event_log).permit(
      :event_date,
      :state,
      :city,
      :source,
      :category,
      :venue,
      :rating,
      :event_type,
      event_categories: []
    )
  end
end
