class News < ApplicationRecord
  default_scope { order(created_at: :desc) }

  validates :title, :body, presence: true
end
