class Member < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_one :primary_manager, class_name: 'User', foreign_key: :id, primary_key: :primary_manager_id
  has_many :users, inverse_of: :member, dependent: :destroy
  has_many :events, inverse_of: :member, dependent: :destroy

  validates :name, :address, :city, :state, :zip, :contact_name, :contact_email, :contact_phone, :service_capacity, presence: true
  validates_uniqueness_of :name, case_sensitive: false
  validates :state, inclusion: US_STATES.values
  validates :zip, format: { with: %r{\A[\d]{5}(-[\d]{4})?\z} }
  validates :contact_phone, format: { with: /\A\d{10}\z/, message: 'must be 10 digits including area code' }
  validates_format_of :contact_email, with: /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i

  before_validation { |member| member.contact_phone.gsub!(/\D/,'') if member.contact_phone? }
  before_validation :add_protocol_to_url

  def full_address
    [address, city, state, zip].compact.join(', ')
  end

  def should_generate_new_friendly_id?
    name_changed?
  end

  private

  def add_protocol_to_url
    self.url = "http://#{url}" if url.present? && url !~ /\Ahttp/
    self.events_url = "http://#{events_url}" if events_url.present? && events_url !~ /\Ahttp/
  end

end
