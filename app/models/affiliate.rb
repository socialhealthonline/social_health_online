class Affiliate < ApplicationRecord
  SUPPORT_TYPES = ["Events", "Discounts", "Events & Discounts" ].freeze
  SORTABLE_COLUMNS = %w[ name city state support_notes hide_info_on_locator date_added ]

  enum support_types: SUPPORT_TYPES

  validates :name,:address, :city, :state, :zip, :support_type, :contact_phone,
            :contact_email, :contact_name, :date_added, presence: true
  validates_uniqueness_of :name, case_sensitive: false
  validates :state, inclusion: US_STATES.values
  validates :support_type, inclusion: Affiliate.support_types.values
  validates :zip, format: { with: %r{\A[\d]{5}(-[\d]{4})?\z} }
  validates :phone, format: { with: /\A\d{10}\z/, message: 'Must be 10 digits including area code', allow_blank: true }

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
