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
    @event = Event.find params[:id]

    if @event.private? # ensure user is a member of this community before viewing private events
      redirect_to community_path(@member) and return unless authenticated_user.member_id == @event.member_id
    end
  end

  private

  def set_member
    @member = Member.friendly.find params[:community_id]
  end

end
