class Contact < ApplicationRecord
  acts_as_paranoid
  belongs_to :user
  belongs_to :contact, class_name: 'User', foreign_key: 'contact_id'
end
