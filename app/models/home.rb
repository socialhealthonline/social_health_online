class Home < ApplicationRecord
  validates :title, :event_type, presence: true
end
