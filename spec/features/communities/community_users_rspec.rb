require 'rails_helper'

describe 'Community Users List' do
  let(:member) { create(:member) }
  let(:user) { create(:user, member: member) }
  let!(:user_2) { create(:user, member: member, name: 'Second User') }
  let!(:user_3) { create(:user, member: member, name: 'Third User', user_status: :disabled) }

  before do
    sign_in user
    visit community_path(member)
  end

  context 'User is on the page' do
    it 'User is displayed on the community page' do
      click_link 'User List'
      expect(page).to have_content user_2.name
    end
  end

  context 'User is not on the page' do
    it 'Disabled user is not displayed on the community page' do
      click_link 'User List'
      expect(page).to_not have_content user_3.name
    end

    it 'Current is not displayed on the community page' do
      click_link 'User List'
      expect(page).to_not have_content user.name
    end
  end
end
