class EventCategory < ApplicationRecord
  belongs_to :social_event_log
  validates_presence_of :name

  validates :name, inclusion: EVENT_CATEGORIES
end
