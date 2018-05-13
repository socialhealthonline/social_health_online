class EventCategory < ApplicationRecord
  belongs_to :social_event_log
  validates_presence_of :name
  validates_uniqueness_of :name, scope: :social_event_log_id
  # validates :name, uniqueness: { scope: :social_event_log, message: "no duplicate categories" }
end
