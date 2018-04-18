class EventForCalendarSerializer < ActiveModel::Serializer
  attributes :id, :title, :details, :start, :allDay, :url, :color

  def url
    # "/events/#{object.id}"
    '#'
  end

  def start
    object.start_at
  end

  def allDay
    true
  end

  def color
    object.private? ? '#c9302c' : nil
  end

end
