require 'rails_helper'

RSpec.describe Event do

  it { should have_db_index(:member_id) }
  it { should have_db_index(:start_at) }
  it { should have_db_index(:event_type) }
  it { should have_db_index(:private) }

  it { should belong_to(:member) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :start_at }
  it { should validate_presence_of :event_type }

  describe 'valid US state' do
    it { should allow_value('FL', 'DC').for(:state) }
    it { should_not allow_value('AB').for(:state) }
  end

  describe 'valid event type' do
    it { should allow_value('Film', 'Games').for(:event_type) }
    it { should_not allow_value('Racing').for(:event_type) }
  end

end
