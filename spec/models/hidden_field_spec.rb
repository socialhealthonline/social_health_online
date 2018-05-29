require 'rails_helper'

RSpec.describe HiddenField, type: :model do
  let(:member) { create(:member) }
  let!(:user) { create(:user, member: member) }
  it { should belong_to(:user) }
  it { should validate_uniqueness_of(:user_id) }
end
