class User < ApplicationRecord
  ETHNICITY = ['Black', 'White', 'Hispanic', 'Asian', 'American Indian', 'Pacific Islander', 'Other']
  GENDER = ['Male', 'Female', 'Other']
  RELATIONSHIP_STATUS = ['Single', 'In a Relationship', 'Married', 'Other']
  EDUCATION_LEVEL = ['High School', 'College', 'Advanced Graduate', 'Other']
  enum user_status: %i[disabled enabled pending]

  acts_as_paranoid

  belongs_to :member, inverse_of: :users
  has_many :social_event_logs, dependent: :destroy
  has_many :social_fitness_logs, dependent: :destroy
  has_many :rsvps
  has_many :bulletins
  has_many :events, through: :rsvps
  has_one :hidden_field
  has_one_attached :avatar

  validates :name, :display_name, :email, :address, :city, :birthdate, :time_zone, :interest_types, presence: true
  validates :hide_info_on_leaderboard, :hide_info_on_user_finder, :hide_my_social_events, :hide_my_social_health, :gender, :ethnicity, :group, :guest, presence: true, allow_blank: true
  validates_uniqueness_of :email, :display_name, case_sensitive: false
  validates_format_of :email, with: /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  validates_length_of :password, minimum: 8, too_short: 'Must be at least 8 characters.', allow_nil: true
  validates_format_of :password, with: /\A(?=.*[a-z])(?=.*\d).+\z/i, message: 'Must be alphanumeric.', allow_nil: true
  validates_inclusion_of  :interest_types, in: INTEREST_TYPES
  validates :state, inclusion: US_STATES.values
  validates :phone, format: { with: /\A\d{10}\z/, message: 'Must be 10 digits including area code' }
  validates :zip, format: { with: %r{\A[\d]{5}(-[\d]{4})?\z} }
  validate :avatar_validation
  validates_inclusion_of :relationship_status, in: RELATIONSHIP_STATUS, allow_blank: true
  validates_inclusion_of :education_level, in: EDUCATION_LEVEL, allow_blank: true

  before_save { |user| user.email.downcase! }
  before_validation { |user| user.phone.gsub!(/\D/,'') if user.phone? }
  accepts_nested_attributes_for :hidden_field

  scope :all_except, ->(user) { where.not(id: user) }
  scope :matchmaker, ->(user) { where("hidden_fields.user_id != ? and hidden_fields.settings @> ?", user.id, { matchmaker: '0' }.to_json).where(user_status: :enabled) }

  has_secure_password
  has_secure_token :auth_token
  has_secure_token :password_reset_token

  acts_as_messageable

  def avatar_validation
    if avatar.attached?
      if avatar.blob.byte_size > 10.megabytes
        errors[:avatar] << 'This file exceeds the maximum allowed file size (10 mb).'
      elsif !avatar.blob.content_type.starts_with?('image/')
        errors[:avatar] << 'Only image files with extensions .jpg, .jpeg, .gif, or .png are allowed.'
      end
    end
  end

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
    self.password = SecureRandom.urlsafe_base64(6, true)
    self.password_confirmation = self.password
  end

  def total_social_events_logged
    social_event_logs.size
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
end
