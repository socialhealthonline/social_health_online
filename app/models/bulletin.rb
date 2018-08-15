class Bulletin < ApplicationRecord
  belongs_to :user

  validates :title, :description, :start_at, presence: true
end
