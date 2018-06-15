require 'rails_helper'

describe MemberHelper do
  let!(:member_1) { create(:member, name: 'Member 1') }
  let!(:member_2) { create(:member, name: 'Member 2') }

  describe '#csv_member_list' do
    it 'export members as csv' do
      expected_csv = file_fixture('members.csv').read
      generated_csv = helper.csv_member_list
      expect(generated_csv).to eq expected_csv
    end
  end
end
