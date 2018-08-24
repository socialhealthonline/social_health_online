class Affiliate < ApplicationRecord
  SUPPORT_TYPES = ["Events", "Discounts", "Events & Discounts" ].freeze
  SORTABLE_COLUMNS = %w[ name city state support_notes hide_info_on_locator org_type date_added ]

  enum support_types: SUPPORT_TYPES

  has_one_attached :logo

  validates :name,:address, :city, :state, :zip, :support_type, :contact_phone, :org_type,
            :contact_email, :contact_name, :date_added, presence: true
  validates_uniqueness_of :name, case_sensitive: false
  validates :state, inclusion: US_STATES.values
  validates :org_type, inclusion: ORG_TYPES
  validates :support_type, inclusion: Affiliate.support_types.values
  validates :zip, format: { with: %r{\A[\d]{5}(-[\d]{4})?\z} }
  validates :phone, format: { with: /\A\d{10}\z/, message: 'Must be 10 digits including area code', allow_blank: true }
  validate :logo_validation

  before_validation { |affiliate| affiliate.phone.gsub!(/\D/,'') if affiliate.phone? }
  before_validation :add_protocol_to_url

  def full_address
    [address, city, state, zip].compact.join(', ')
  end

  def logo_validation
    if logo.attached?
      if logo.blob.byte_size > 10.megabytes
        errors[:logo] << 'This file exceeds the maximum allowed file size (10 mb).'
      elsif !logo.blob.content_type.starts_with?('image/')
        errors[:logo] << 'Only image files with extensions .jpg, .jpeg, .gif, or .png are allowed.'
      end
    end
  end

  private

  def add_protocol_to_url
    self.url = "http://#{url}" if url.present? && url !~ /\Ahttp/
  end

end
