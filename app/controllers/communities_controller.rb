class CommunitiesController < ApplicationController
  before_action :require_authentication

  def show
    @member = Member.friendly.find params[:id]
  end

  def events
    @member = Member.friendly.find params[:id]

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

end
