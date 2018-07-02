class UserEventRsvpAnswerService
  def initialize(params, authenticated_user)
    @params = params
    @event = Event.find_by(id: params[:id])
    @rsvp_switcher = authenticated_user.rsvps.find_or_initialize_by(event_id: params[:id])
  end

  def call
    if @rsvp_switcher.new_record? && !@event.rsvp_limit_reached?
      create_user_rsvp
    else
      update_user_rsvp unless reached_event_not_update_to_yes?
    end
  end

  private

  def create_user_rsvp
    @rsvp_switcher.tap do |rsvp|
      rsvp.event_id = @params[:id]
      rsvp.rsvp_status = @params[:event].downcase.strip
      rsvp.save!
    end
  end

  def update_user_rsvp
    @rsvp_switcher.update(event_id: @params[:id], rsvp_status: @params[:event].downcase.strip)
  end

  def reached_event_not_update_to_yes?
    @event.rsvp_limit_reached? && @params[:event].downcase.strip.eql?('yes')
  end
end
