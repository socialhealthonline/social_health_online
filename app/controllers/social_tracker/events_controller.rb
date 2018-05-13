class SocialTracker::EventsController < ApplicationController
  before_action :require_authentication

  def new
    @social_event_log = SocialEventLog.new
  end

  def create
    @social_event_log = authenticated_user.social_event_logs.build(log_params)

    if @social_event_log.save
      redirect_to social_tracker_history_url, success: "The event was logged successfully!"
    else
      flash.now[:error] = "Please correct the errors to continue."
      render :new
    end
  end

  def index
    @social_event_logs = authenticated_user.social_event_logs.paginate(page: params[:page])
  end

  def show
    @log = authenticated_user.social_event_logs.find(params[:id])
  end

  private

  def log_params
    params.require(:social_event_log).permit(
      :event_date,
      :state,
      :city,
      :event_type,
      :source,
      :category,
      :venue,
      :rating,
      event_categories_attributes: [:id, :name, :_destroy],
    )
  end
end
