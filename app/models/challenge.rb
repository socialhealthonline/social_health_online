class Challenge < ApplicationRecord
  validates :description, :name, :challenge_type, presence: true
  belongs_to :member

  def location_display
    [address, city, state, zip].join(', ')
  end

end
