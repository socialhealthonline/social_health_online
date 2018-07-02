require 'rails_helper'

RSpec.describe Rsvp, type: :model do
  let(:member) { create(:member) }
  let(:user) { create(:user, member: member) }
  let(:event) { create(:event, member: member)}
  subject { create(:rsvp, event: event, user: user) }

  it { should have_db_index(:event_id) }
  it { should have_db_index(:user_id) }

  it { should belong_to(:user) }
  it { should belong_to(:event) }

  it { should validate_presence_of(:rsvp_status) }
  it { should allow_values("yes", "maybe", "no").for(:rsvp_status) }
  it { should validate_uniqueness_of(:user_id).scoped_to(:event_id) }
end
