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

  def social_fitness_csv
    attributes = %w{state name user_name user_email individuals groups family friends colleagues significant_other local_community overall}
    user_attributes = %w{name email}
    fitness_attributes = %w{individuals groups family friends colleagues significant_other local_community overall}
    ratings_attributes = %w{individuals groups overall}

    ::CSV.generate(headers: true) do |csv|
      csv << attributes
      
      users.each do |user|
        row = []
        values = [state, name]
        user_values = user_attributes.map{ |attr| user.send(attr) }
        
        user.social_fitness_logs.each do |log|
          fitness_values = fitness_attributes.map do |attr| 
            if ratings_attributes.include? attr
              RATINGS.key(log.send(attr)).to_s
            else
              RATINGS_WITH_NA.key(log.send(attr)).to_s
            end
          end
          values.push(*user_values,*fitness_values)

          row.push(values)
        end
        csv << row
      end
    end
  end

  private

  def add_protocol_to_url
    self.url = "http://#{url}" if url.present? && url !~ /\Ahttp/
    self.events_url = "http://#{events_url}" if events_url.present? && events_url !~ /\Ahttp/
  end

end
