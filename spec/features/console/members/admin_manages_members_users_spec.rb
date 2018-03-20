require 'rails_helper'

RSpec.describe 'Admin mananges members users' do

  let!(:admin) { create(:user, :admin) }
  let!(:member) { create(:member) }

  describe 'creates a new user' do
    before do
      sign_in admin
      visit console_member_users_path(member)
      click_link 'Add User'
    end

    it 'successfully' do
      fill_in 'user_name', with: 'Bob Smith'
      fill_in 'user_display_name', with: 'Bobby'
      fill_in 'user_email', with: 'bob@example.com'
      fill_in 'user_phone', with: '5555555555'
      fill_in 'user_address', with: '123 Main St.'
      fill_in 'user_city', with: 'Hometown'
      select 'Alabama', from: 'user_state'
      fill_in 'user_zip', with: '55555'
      select 'Eastern Time (US & Canada)', from: 'user_time_zone'
      fill_in 'user_birthdate', with: '1970-1-1'
      select 'Female', from: 'user_gender'
      select 'Asian', from: 'user_ethnicity'
      check 'user_manager'
      click_button 'Save'
      expect(page).to have_content 'The user was successfully created'
      expect(current_path).to eq console_member_user_path(member, User.last)
      expect(User.last.manager).to eq true
      expect(member.users.count).to eq 1
      expect(unread_emails_for(User.last.email).size).to eq 1
    end

    it 'unsuccessfully' do
      fill_in 'user_name', with: ''
      click_button 'Save'
      expect(member.users.count).to eq 0
    end
  end

  describe 'edits a user' do
    let!(:user) { create(:user, member: member) }

    before do
      sign_in admin
      visit edit_console_member_user_path(member, user)
    end

    it 'successfully' do
      fill_in 'user_name', with: 'Tom Jones Jr.'
      check 'user_manager'
      click_button 'Save'
      user.reload
      expect(user.name).to eq 'Tom Jones Jr.'
      expect(user.manager?).to eq true
    end

    it 'unsuccessfully' do
      fill_in 'user_name', with: ''
      click_button 'Save'
      user.reload
      expect(user.name).to_not eq ''
    end
  end

  describe 'deletes a user' do
    let!(:user) { create(:user, member: member) }

    before do
      sign_in admin
      visit console_member_users_path(member)
    end

    it 'successfully' do
      expect { click_link "delete_user_#{user.id}" }.to change{ User.count }.by(-1)
      expect(current_path).to eq console_member_users_path(member)
    end
  end

end
