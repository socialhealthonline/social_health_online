class Event < ApplicationRecord
  belongs_to :member, inverse_of: :events
  has_many :rsvps
  has_many :users, :through => :rsvps
  
  validates :title, :start_at, :event_type, presence: true
  validates :event_type, inclusion: EVENT_TYPES
  validates :state, inclusion: US_STATES.values, allow_nil: true
  validate :validate_rsvp_limit, on: :update

  before_validation :add_protocol_to_url

  def location_display
    [location, city, state].join(', ')
  end

  def rsvp_limit_reached?
    return false unless rsvp_limit
    rsvps.yes.count == rsvp_limit
  end

  private

  def add_protocol_to_url
    self.url = "http://#{url}" if url.present? && url !~ /\Ahttp/
  end

  def validate_rsvp_limit
    return true unless rsvp_limit
    if rsvp_limit < rsvps.yes.count
      errors[:rsvp_limit] << "Caution - RSVP Limit cannot be less than the number of recorded 'Yes' responses."
    end
  end
end
