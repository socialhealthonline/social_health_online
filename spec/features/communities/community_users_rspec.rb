require 'rails_helper'

feature 'Community Users List', type: :feature, js: true do
  let(:member) { create(:member) }
  let(:user) { create(:user, member: member, name: 'First User') }
  let!(:user_2) { create(:user, member: member, name: 'Second User') }
  let!(:user_3) { create(:user, :disabled_status, member: member, name: 'Third User') }

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
      expect(page).to have_no_content user_3.name
    end
  end
end
