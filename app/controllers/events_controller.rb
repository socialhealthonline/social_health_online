class EventsController < ApplicationController
  before_action :require_authentication
  before_action :set_member

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
    @events = Event.where(member_id: authenticated_user.member_id).order(start_at: :desc).page(params[:page]).per(5)
    @events = Event.where("start_at >= ?", Time.zone.now).where(state: [@authenticated_user.state]).where(city: [@authenticated_user.city]).where(private: false).order(start_at: :desc).page(params[:page]).per(3)
    @rsvp_switcher = authenticated_user.rsvps.find_by(event_id: params[:id])
    @event = Event.find(params[:id]).decorate

    if @event.private? # ensure user is a member of this community before viewing private events
      redirect_to community_path(@member) and return unless authenticated_user.member_id == @event.member_id
    end
  end

  def create_or_switch_rsvp
    unless UserEventRsvpAnswerService.new(params, authenticated_user).call
      flash[:error] = 'The RSVP limit for this event is reached'
    end
    redirect_to community_event_path(@member, params[:id])
  end

  private

  def set_member
    @member = Member.friendly.find params[:community_id]
  end

end
