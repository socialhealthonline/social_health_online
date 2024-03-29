class Bulletin < ApplicationRecord
  belongs_to :user
  validates :title, :event_type, :state, :description, :start_at, presence: true

  def location_display
    [address, city, state, zip].join(', ')
  end

end
