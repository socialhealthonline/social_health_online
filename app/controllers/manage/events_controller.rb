class Manage::EventsController < ApplicationController
  before_action :require_manager
  around_action :param_time_zone, only: [:create, :update]
  around_action :event_time_zone, only: [:edit]
  helper_method :sort_column, :sort_direction

  def index
    @events = Event.order("#{sort_column} #{sort_direction}").page(params[:page])
    @events = Event.where(member_id: authenticated_user.member_id).order(start_at: :desc).page(params[:page]).per(25)
    @member = authenticated_user.member_id
  end

  def show
    @event = Event.find_by!(member_id: authenticated_user.member_id, id: params[:id])
  end

  def new
    @event = Event.new(time_zone: authenticated_user.time_zone)
  end

  def create
    @event = authenticated_user.member.events.build(event_params)
    if @event.save
      redirect_to manage_event_url(@event), success: 'The event was successfully created!'
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :new
    end
  end

  def edit
    @event = Event.find_by!(member_id: authenticated_user.member_id, id: params[:id])
  end

  def update
    @event = Event.find_by!(member_id: authenticated_user.member_id, id: params[:id])
    if @event.update(event_params)
      redirect_to manage_event_url(@event), success: 'The event was successfully updated!'
    else
      update_action_flash_error
      render :edit
    end
  end

  def destroy
    @event = Event.find_by!(member_id: authenticated_user.member_id, id: params[:id])
    @event.destroy
    redirect_to manage_events_url, success: 'The event was successfully deleted!'
  end

  private

    def event_params
      params.require(:event).permit(
        :title,
        :start_at,
        :time_zone,
        :event_type,
        :state,
        :city,
        :location,
        :url,
        :details,
        :private,
        :rsvp_limit,
        :address,
        :zip
      )
    end

    def sortable_columns
      %w[
        title event_type start_at location city state
      ]
    end

    def sort_column
      logger.debug("SORT:::: #{params[:direction].inspect}")
      sortable_columns.include?(params[:column]) ? params[:column] : 'title'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end

    def param_time_zone
      if params[:event][:time_zone].present?
        Time.use_zone(params[:event][:time_zone]) { yield }
      else
        yield
      end
    end

    def event_time_zone
      @event = Event.find_by!(member_id: authenticated_user.member_id, id: params[:id])
      Time.use_zone(@event.time_zone) { yield }
    end

    def update_action_flash_error
      if @event.errors[:rsvp_limit].empty?
        flash.now[:error] = 'Please correct the errors to continue.'
      else
        flash.now[:error] = @event.errors[:rsvp_limit].first
      end
    end
  end
end
