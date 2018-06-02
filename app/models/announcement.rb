class Announcement < ApplicationRecord
  validates :title, :body, presence: true
  belongs_to :member
end
