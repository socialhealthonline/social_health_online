class Notification < ApplicationRecord
  default_scope { order('updated_at desc') }
  validates :title, :body, presence: true
end
