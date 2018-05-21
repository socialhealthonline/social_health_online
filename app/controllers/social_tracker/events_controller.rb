class SocialTracker::EventsController < ApplicationController
  before_action :require_authentication

  def new
    @social_event_log = SocialEventLog.new
  end

  def create
    parameters = log_params.to_h
    types = build_event_types(parameters[:event_types])
    categories = build_event_categories(parameters[:event_categories])

    @social_event_log = authenticated_user.social_event_logs.build(parameters.except(:event_types,:event_categories))
    @social_event_log.event_types = types if types
    @social_event_log.event_categories = categories if categories

    if @social_event_log.save
      redirect_to social_tracker_history_url, success: "The event was logged successfully!"
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

  def build_event_types(types)
    return if types.empty?
    types.map { |type_name| EventType.new(name: type_name) }
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
      event_categories: [],
      event_types: []
    )
  end
end
