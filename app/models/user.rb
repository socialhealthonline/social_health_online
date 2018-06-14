class User < ApplicationRecord
  ETHNICITY = ['Black', 'White', 'Hispanic', 'Asian', 'American Indian', 'Pacific Islander', 'Other']
  GENDER = ['Male', 'Female', 'Other']
  RELATIONSHIP_STATUS = ['Single', 'In a relationship', 'Married', 'Other']
  EDUCATION_LEVEL = ['High School', 'College', 'Advanced Graduate', 'Other']
  enum user_status: %i[pending enabled disabled]

  belongs_to :member, inverse_of: :users
  has_many :social_event_logs
  has_many :social_fitness_logs
  has_many :rsvps
  has_many :events, through: :rsvps
  has_one :hidden_field

  validates :name, :email, :address, :city, :gender, :ethnicity, :birthdate, :time_zone, presence: true
  validates_uniqueness_of :email, case_sensitive: false
  validates_format_of :email, with: /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  validates_length_of :password, minimum: 8, too_short: 'must be at least 8 characters', allow_nil: true
  validates_format_of :password, with: /\A(?=.*[a-z])(?=.*\d).+\z/i, message: 'must be alphanumeric', allow_nil: true
  validates :state, inclusion: US_STATES.values
  validates :phone, format: { with: /\A\d{10}\z/, message: 'must be 10 digits including area code' }
  validates :zip, format: { with: %r{\A[\d]{5}(-[\d]{4})?\z} }
  validates_inclusion_of :gender, in: GENDER
  validates_inclusion_of :ethnicity, in: ETHNICITY
  validates_inclusion_of :relationship_status, in: RELATIONSHIP_STATUS, allow_blank: true
  validates_inclusion_of :education_level, in: EDUCATION_LEVEL, allow_blank: true

  before_save { |user| user.email.downcase! }
  before_validation { |user| user.phone.gsub!(/\D/,'') if user.phone? }
  accepts_nested_attributes_for :hidden_field

  scope :all_except, ->(user) { where.not(id: user) }
  scope :matchmaker, ->(user) { where("hidden_fields.user_id != ? and hidden_fields.settings @> ?", user.id, { matchmaker: true }.to_json).where(user_status: :activated) }

  has_secure_password
  has_secure_token :auth_token
  has_secure_token :password_reset_token

  acts_as_messageable

  def mailboxer_name
    self.name
  end

  def mailboxer_email(object)
    self.email if receive_email
  end

  def full_address
    [address, city, state, zip].compact.join(', ')
  end

  def erase_password_reset_fields
    self.password_reset_token = nil
    self.password_reset_sent_at = nil
    self.save(validate: false)
  end

  def set_random_password
    self.password = SecureRandom.urlsafe_base64(32, true)
    self.password_confirmation = self.password
  end

  def total_social_events_logged
    social_event_logs.count
  end

  def last_social_event_log_date
    social_event_logs.first&.created_at
  end

  def total_social_fitness_logs
    social_fitness_logs.count
  end

  def last_social_fitness_log_date
    social_fitness_logs.first&.created_at
  end

  # from String to Boolean all attrs except :id
  # @param attrs [Hash]
  def hidden_field_attributes=(attrs)
    attrs.except(:id).each { |k, v| attrs[k] = ActiveRecord::Type::Boolean.new.cast(v) }
    super(attrs)
  end
end
