class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :contact, class_name: 'User', foreign_key: 'contact_id'
end
