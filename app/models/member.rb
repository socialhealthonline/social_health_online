class Member < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_one :primary_manager, class_name: "User", foreign_key: :id, primary_key: :primary_manager_id
  has_many :users, inverse_of: :member, dependent: :destroy
  has_many :events, inverse_of: :member, dependent: :destroy
  has_many :announcements, dependent: :destroy
  has_one_attached :logo

  validates :name, :address, :city, :state, :zip, :contact_name, :contact_email, :contact_phone, :service_capacity, presence: true
  validates_uniqueness_of :name, case_sensitive: false
  validates :state, inclusion: US_STATES.values
  validates :zip, format: {with: %r{\A[\d]{5}(-[\d]{4})?\z}}
  validates :contact_phone, format: {with: /\A\d{10}\z/, message: "must be 10 digits including area code"}
  validates_format_of :contact_email, with: /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  validate :logo_validation

  before_validation { |member| member.contact_phone.gsub!(/\D/, "") if member.contact_phone? }
  before_validation :add_protocol_to_url

  def logo_validation
    if logo.attached?
      if logo.blob.byte_size > 5.megabytes
        logo.purge
        errors[:logo] << 'This file exceeds the maximum allowed file size (5 MB)'
      elsif !logo.blob.content_type.starts_with?('image/')
        logo.purge
        errors[:logo] << 'Only image file with extension: .jpg, .jpeg, .gif or .png is allowed'
      end
    end
  end

  def full_address
    [address, city, state, zip].compact.join(", ")
  end

  def should_generate_new_friendly_id?
    name_changed?
  end

  def social_fitness_csv
    attributes = %w{log_date state name user_name user_email individuals groups family friends colleagues significant_other local_community overall}
    user_attributes = %w{name email}
    fitness_attributes = %w{individuals groups family friends colleagues significant_other local_community overall}
    ratings_attributes = %w{individuals groups overall}

    ::CSV.generate(headers: true) do |csv|
      csv << attributes

      users.each do |user|
        values = [state, name]
        user_values = user_attributes.map { |attr| user.send(attr) }

        user.social_fitness_logs.each do |log|
          row = []
          fitness_values = fitness_attributes.map do |attr|
            if ratings_attributes.include? attr
              RATINGS.key(log.send(attr)).to_s
            else
              RATINGS_WITH_NA.key(log.send(attr)).to_s
            end
          end
          row.push(log.created_at, *values, *user_values, *fitness_values)
          csv << row
        end
      end
    end
  end

  def social_tracker_csv
    attributes = %w{log_date state name primary_manager_name primary_manager_email user_name user_email event_date event_state event_city event_type event_source event_category event_venue event_rating}
    tracker_attributes = %w{event_date state city event_type source event_categories venue rating}
    user_attributes = %w{name email}

    ::CSV.generate(headers: true) do |csv|
      csv << attributes

      users.each do |user|
        values = [state, name]
        user_values = user_attributes.map { |attr| user&.send(attr) }
        primary_manager_values = user_attributes.map { |attr|
          val = primary_manager&.send(attr)
          val ? val : ""
        }
        user.social_event_logs.each do |log|
          row = []
          tracker_values = tracker_attributes.map do |attr|
            case attr
            when "state"
              US_STATES.key(log.send(attr))
            when "event_type"
              EVENT_TYPES[log.send(attr)&.to_i].to_s
            when "source"
              SocialEventLog::EVENT_SOURCES.key(log.send(attr))
            when "rating"
              RATINGS.key(log.send(attr)).to_s
            when "event_categories"
              category = ""
              log.send(attr).each { |cat| category += cat.name + " " }
              category.strip
            else
              log.send(attr)
            end
          end
          row.push(log.created_at, *values, *primary_manager_values, *user_values, *tracker_values)
          csv << row
        end
      end
    end
  end

  private

  def add_protocol_to_url
    self.url = "http://#{url}" if url.present? && url !~ /\Ahttp/
    self.events_url = "http://#{events_url}" if events_url.present? && events_url !~ /\Ahttp/
  end
end
