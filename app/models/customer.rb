class Customer < ApplicationRecord

  has_many :users, inverse_of: :customer, dependent: :destroy

  validates :name, :address, :city, :state, :contact_name, :service_capacity, presence: true
  validates_uniqueness_of :name, case_sensitive: false
  validates :state, inclusion: US_STATES.values
  validates :zip, format: { with: %r{\A[\d]{5}(-[\d]{4})?\z} }
  validates :contact_phone, format: { with: /\A\d{10}\z/, message: 'must be 10 digits including area code' }
  validates_format_of :contact_email, with: /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i

  before_validation { |customer| customer.contact_phone.gsub!(/\D/,'') if customer.contact_phone? }

  def full_address
    [address, city, state, zip].compact.join(', ')
  end

end
