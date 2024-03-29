class EventsController < ApplicationController
  before_action :require_authentication
  before_action :set_member
  helper_method :sort_column, :sort_direction

  def index
    events = []
    if authenticated_user.member_id == @member.id
      events = Event.where('start_at >= ?', params[:start])
        .where('start_at <= ?', params[:end])
        .where(member_id: @member.id)
    else
      events = Event.where('start_at >= ?', params[:start])
        .where('start_at <= ?', params[:end])
        .where(member_id: @member.id)
        .where(private: false)
    end

    render json: events, each_serializer: EventForCalendarSerializer
  end

  def show
    @events = Event.where("id != ?", params[:id])
	           .where("start_at >= ?", Time.zone.now)
	           .where(state: [@authenticated_user.state])
	           .where(city: [@authenticated_user.city])
	           .where(private: false).order("#{sort_column} #{sort_direction}").page(params[:page]).per(5)
    @rsvp_switcher = authenticated_user.rsvps.find_by(event_id: params[:id])
    @event = Event.find(params[:id]).decorate

    if @event.private? # ensure user is a member of this community before viewing private events
      redirect_to community_path(@member) and return unless authenticated_user.member_id == @event.member_id
    end
  end

  def create_or_switch_rsvp
    unless UserEventRsvpAnswerService.new(params, authenticated_user).call
      flash[:error] = 'The RSVP attendee limit for this event has been reached!'
    end
    redirect_to community_event_path(@member, params[:id])
  end

  private

  def set_member
    @member = Member.friendly.find params[:community_id]
  end

  def sortable_columns
    %w[
      title start_at event_type
    ]
  end

  def sort_column
    logger.debug("SORT:::: #{params[:direction].inspect}")
    sortable_columns.include?(params[:column]) ? params[:column] : 'created_at'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

end
