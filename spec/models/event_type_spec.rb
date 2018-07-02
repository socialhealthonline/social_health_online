require 'rails_helper'

RSpec.describe EventType, type: :model do
  let(:social_event_log) { create(:social_event_log) }
  it { should validate_inclusion_of(:name).in_array(EVENT_TYPES) }
end
