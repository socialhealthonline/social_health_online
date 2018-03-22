class Event < ApplicationRecord
  TYPES = ['Art/Photography', 'Career/Business', 'Dance/Theater', 'Family/Kids', 'Fashion/Beauty', 'Festivals/Fairs', 'Film', 'Food/Drink', 'Games', 'Health/Wellness', 'Hobbies/Crafts', 'Language/Culture', 'Language/Culture', 'Learning/Education', 'Music', 'Nightlife', 'Other', 'Outdoor/Adventure', 'Pets/Animals', 'Reading/Writing', 'Religion/Beliefs', 'Seniors', 'Social Movements', 'Sports/Fitness', 'Tech', 'Volunteer/Charity' ]

  belongs_to :member, inverse_of: :events

  validates :title, :start_at, :event_type, presence: true
  validates :event_type, inclusion: TYPES
  validates :state, inclusion: US_STATES.values, allow_nil: true

  before_validation :add_protocol_to_url

  private

  def add_protocol_to_url
    self.url = "http://#{url}" if url.present? && url !~ /\Ahttp/
  end
end
