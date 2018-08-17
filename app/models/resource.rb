class Resource < ApplicationRecord
  validates :name, :state, :url, presence: true
end
