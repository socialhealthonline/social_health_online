class Rsvp < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum rsvp_statuses: %i[yes maybe no]
  validates_uniqueness_of :user_id, scope: :event_id
  validates :rsvp_status, presence: true, inclusion: { in: rsvp_statuses, message: "Rsvp status should be in: %{value}" }
end
