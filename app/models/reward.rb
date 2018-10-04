class Reward < ApplicationRecord
  validates :period, :display_name, :member_name, :state, :prize, presence: true
end
