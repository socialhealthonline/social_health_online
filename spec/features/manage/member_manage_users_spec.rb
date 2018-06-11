require 'rails_helper'

RSpec.describe 'Send invites users and manage them' do
  let(:member) { create(:member) }
  let!(:manager) { create(:user, :manager, member: member) }
  let!(:user) { create(:user, member: member) }
  let!(:user_2) { create(:user, member: member, user_status: :pending )}

  before do
    sign_in manager
    visit manage_users_path
  end

  context 'successfully invite users' do
    it 'fills up the form with uniq emails' do
      expect(page).to have_content('My Community Users')
      visit new_manage_user_path
      expect(page).to have_content('Add Users')
      fill_in 'email_1', with: 'email1@gmail.com'
      fill_in 'email_2', with: 'email2@gmail.com'
      click_button 'Send'
      expect(page).to have_content('Successfully send intivations!')
    end
  end

  context 'unsuccessfully invite users' do
    it 'fills up the form with existed emails' do
      expect(page).to have_content('My Community Users')
      visit new_manage_user_path
      expect(page).to have_content('Add Users')
      fill_in 'email_1', with: 'email1@gmail.com'
      fill_in 'email_2', with: 'email2@gmail.com'
      fill_in 'email_3', with: 'email2@gmail.com'
      click_button 'Send'
      expect(page).to have_content('User with email: email2@gmail.com already exists')
    end
  end

  context 'manage users' do
    it 'successfully change user status' do
      expect(page).to have_content('My Community Users')
      visit edit_manage_user_path(user)
      expect(page).to have_content(user.email)
      select('disabled', from: 'user_user_status')
      click_button 'Update'
      expect(page).to have_content('Profile was successfully updated!')
    end

    it "manage can't change user status" do
      expect(page).to have_content('My Community Users')
      visit edit_manage_user_path(user_2)
      expect(page).to have_content(user_2.email)
      find_field 'user_user_status', disabled: true
    end
  end
end
