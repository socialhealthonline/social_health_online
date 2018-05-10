class Event < ApplicationRecord
  belongs_to :member, inverse_of: :events

  validates :title, :start_at, :event_type, presence: true
  validates :event_type, inclusion: EVENT_TYPES
  validates :state, inclusion: US_STATES.values, allow_nil: true

  before_validation :add_protocol_to_url

  def location_display
    [location, city, state].join(', ')
  end

  private

  def add_protocol_to_url
    self.url = "http://#{url}" if url.present? && url !~ /\Ahttp/
  end

end
