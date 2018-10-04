class Challenge < ApplicationRecord
  belongs_to :member
  validates :description, :name, :challenge_type, :address, :zip, :challenge_start_date, :location, :city, :state, :challenge_end_date, presence: true
  belongs_to :member

  def location_display
    [address, city, state, zip].join(', ')
  end

end
