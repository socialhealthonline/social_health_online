require 'rails_helper'

RSpec.describe SocialEventLog, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :event_date }
    it { should validate_presence_of :state }
    it { should validate_presence_of :city }
    it { should validate_presence_of :event_type }
    it { should validate_presence_of :source }
    it { should validate_presence_of :rating }
    it { should validate_inclusion_of(:state).in_array(US_STATES.values) }
    it { should validate_inclusion_of(:event_type).in_array(EVENT_TYPES) }
    it { should validate_inclusion_of(:source).in_array(SocialEventLog::EVENT_SOURCES.values) }
    it { should validate_inclusion_of(:rating).in_array(RATINGS.values) }
  end

  describe 'Association' do
    it { should belong_to(:user) }
  end
end
