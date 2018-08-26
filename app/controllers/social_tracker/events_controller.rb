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
    source = parameters[:source]

    if source.eql? 1
      parameters = parameters.except(:event_category)
    end

    @social_event_log = authenticated_user.social_event_logs.build(parameters)

    if daily_events_logged < 3 && @social_event_log.save
      redirect_to social_tracker_history_url, success: "The event was logged successfully!"
    elsif daily_events_logged >= 3
      flash.now[:error] = 'Unsuccessfully logged event. You can log a maximum of 3 events per day.'
      render :new
    else
      flash.now[:error] = "Please correct the errors to continue."
      render :new
    end
  end

  def index
    @social_event_logs = authenticated_user.social_event_logs.page(params[:page]).per(20)
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

  def log_params
    params.require(:social_event_log).permit(
      :event_date,
      :state,
      :city,
      :source,
      :category,
      :venue,
      :rating,
      :event_type,
      :event_category
    )
  end
end
