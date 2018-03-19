class Affiliate < ApplicationRecord

  validates :name, :address, :city, :state, :zip, presence: true
  validates_uniqueness_of :name, case_sensitive: false
  validates :state, inclusion: US_STATES.values
  validates :zip, format: { with: %r{\A[\d]{5}(-[\d]{4})?\z} }
  validates :phone, format: { with: /\A\d{10}\z/, message: 'must be 10 digits including area code', allow_blank: true }

  before_validation { |affiliate| affiliate.phone.gsub!(/\D/,'') if affiliate.phone? }
  before_validation :add_protocol_to_url

  def full_address
    [address, city, state, zip].compact.join(', ')
  end

  private

  def add_protocol_to_url
    self.url = "http://#{url}" if url.present? && url !~ /\Ahttp/
  end

end
