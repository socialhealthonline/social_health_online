class Rsvp < ApplicationRecord
  belongs_to :user
  belongs_to :event
  validates_uniqueness_of :user_id, scope: :event_id

  validates :rsvp_status, presence: true, inclusion: { in: %w(Yes Maybe No), message: "Rsvp status should be in: %{value}" }
end
