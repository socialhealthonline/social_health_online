class SocialEventLog < ApplicationRecord
  EVENT_SOURCES = {
    "Social Health Online": 0,
    "Not Social Health Online": 1,
  }

  default_scope { order("created_at desc") }

  has_many :event_types, dependent: :destroy
  has_many :event_categories, dependent: :destroy

  validates_presence_of :event_date, :state, :city, :event_type, :source, :rating, :venue
  validates_presence_of :event_category, :unless => :source?

  validates :state, inclusion: US_STATES.values

  # 0 - SHO, 1 - Not SHO
  validates_inclusion_of :source, in: EVENT_SOURCES.values

  validates_inclusion_of :rating, in: ::RATINGS.values

  belongs_to :user
end
