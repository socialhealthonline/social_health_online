require 'rails_helper'

RSpec.describe EventCategory, type: :model do
  it { should belong_to(:social_event_log) }
  it { should validate_presence_of :name }
  it { should validate_inclusion_of(:name).in_array(EVENT_CATEGORIES) }
end
