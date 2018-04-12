class News < ApplicationRecord
  validates :title, :body, presence: true
end
