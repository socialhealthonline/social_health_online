class Event < ApplicationRecord
  belongs_to :member, inverse_of: :events
  has_many :rsvps
  has_many :users, :through => :rsvps

  has_one_attached :logo, dependent: :destroy

  validates :title, :start_at, :event_type, :location, :city, :state, :address, :zip, presence: true
  validates :featured_event, presence: true, allow_blank: true
  validates :event_type, inclusion: EVENT_TYPES
  validates :state, inclusion: US_STATES.values, allow_blank: true
  validate :validate_rsvp_limit, on: :update

  before_validation :add_protocol_to_url
  scope :events_for_feed, -> (authenticated_user_id) { where("rsvps.user_id = ? and rsvps.rsvp_status in (?) and start_at >= ?",
                                                       authenticated_user_id, [Rsvp.rsvp_statuses[:yes], Rsvp.rsvp_statuses[:maybe]], Time.zone.now)
                                                       .select('events.*, rsvps.rsvp_status as status') }

  def location_display
    [address, city, state, zip].join(', ')
  end

  def rsvp_limit_reached?
    return false unless rsvp_limit
    rsvps.yes.count == rsvp_limit
  end

  def logo_validation
    if logo.attached?
      if logo.blob.byte_size > 10.megabytes
        errors[:logo] << 'This file exceeds the maximum allowed file size (10 mb).'
      elsif !logo.blob.content_type.starts_with?('image/')
        errors[:logo] << 'Only image files with extensions .jpg, .jpeg, .gif, or .png are allowed.'
      end
    end
  end

  private

  def add_protocol_to_url
    self.url = "http://#{url}" if url.present? && url !~ /\Ahttp/
  end

  def validate_rsvp_limit
    return true unless rsvp_limit
    if rsvp_limit < rsvps.yes.count
      errors[:rsvp_limit] << "Caution - RSVP attendee limit cannot be less than the number of recorded 'Yes' responses"
    end
  end
end
