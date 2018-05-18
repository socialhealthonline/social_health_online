class Event < ApplicationRecord
  belongs_to :member, inverse_of: :events
  has_many :rsvps
  has_many :users, :through => :rsvps
  
  validates :title, :start_at, :event_type, presence: true
  validates :event_type, inclusion: EVENT_TYPES
  validates :state, inclusion: US_STATES.values, allow_nil: true
  validate :validate_rsvp_limit, on: :update

  before_validation :add_protocol_to_url
  scope :events_for_feed, -> (authenticated_user_id) { where("rsvps.user_id = ? and rsvps.rsvp_status in (?) and start_at >= ?",
                                                       authenticated_user_id, ['maybe', 'yes'], Time.zone.now)
                                                       .select('events.*, rsvps.rsvp_status as status') }

  def location_display
    [location, city, state].join(', ')
  end

  def rsvp_limit_reached?
    return false unless rsvp_limit
    rsvps.where(rsvp_status: 'yes').count == rsvp_limit
  end

  private

  def add_protocol_to_url
    self.url = "http://#{url}" if url.present? && url !~ /\Ahttp/
  end

  def validate_rsvp_limit
    return true unless rsvp_limit
    if rsvp_limit < rsvps.where(rsvp_status: 'yes').count
      errors[:rsvp_limit] << "Caution - RSVP Limit cannot be less than the number of recorded 'Yes' responses."
    end
  end
end
