class User < ApplicationRecord

  ETHNICITY = ['Black', 'White', 'Hispanic', 'Asian', 'American Indian', 'Pacific Islander', 'Other']
  GENDER = ['Male', 'Female', 'Other']

  belongs_to :customer, inverse_of: :users, optional: true

  validates :name, :email, :username, :address, :city, :gender, :ethnicity, :birthdate, :time_zone, presence: true
  validates_uniqueness_of :email, case_sensitive: false
  validates_uniqueness_of :username, case_sensitive: false
  validates_format_of :email, with: /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  validates_length_of :password, minimum: 8, too_short: 'must be at least 8 characters', allow_nil: true
  validates_format_of :password, with: /\A(?=.*[a-z])(?=.*\d).+\z/i, message: 'must be alphanumeric', allow_nil: true
  validates :state, inclusion: US_STATES.values
  validates :phone, format: { with: /\A\d{10}\z/, message: 'must be 10 digits including area code' }
  validates :zip, format: { with: %r{\A[\d]{5}(-[\d]{4})?\z} }
  validates_inclusion_of :gender, in: GENDER
  validates_inclusion_of :ethnicity, in: ETHNICITY

  before_save { |user| user.email.downcase! }
  before_validation { |user| user.phone.gsub!(/\D/,'') if user.phone? }

  has_secure_password
  has_secure_token :auth_token
  has_secure_token :password_reset_token

  def full_address
    [address, city, state, zip].compact.join(', ')
  end

  def erase_password_reset_fields
    self.update(password_reset_token: nil, password_reset_sent_at: nil)
  end

  def set_random_password
    self.password = SecureRandom.urlsafe_base64(32, true)
    self.password_confirmation = self.password
  end

end
