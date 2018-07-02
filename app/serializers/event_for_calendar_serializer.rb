class EventForCalendarSerializer < ActiveModel::Serializer
  attributes :id, :title, :details, :start, :allDay, :url, :color

  def url
    "/communities/#{object.member.slug}/events/#{object.id}"
  end

  def start
    object.start_at.in_time_zone(object.time_zone)
  end

  def allDay
    false
  end

  def color
    object.private? ? '#c9302c' : nil
  end

end
