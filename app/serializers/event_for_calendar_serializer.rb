class EventForCalendarSerializer < ActiveModel::Serializer
  attributes :id, :title, :details, :start, :allDay, :url

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

end
