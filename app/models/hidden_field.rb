class HiddenField < ApplicationRecord
  belongs_to :user
  validates :user_id, uniqueness: true
  store_accessor :settings, :zip, :city, :name, :email, :phone, :state, :gender, :address, :birthdate, :ethnicity, :time_zone, :matchmaker  
end
