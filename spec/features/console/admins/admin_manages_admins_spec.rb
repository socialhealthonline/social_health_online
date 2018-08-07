require 'rails_helper'

RSpec.describe 'Admin manages admin users' do

  let!(:admin) { create(:user, :admin) }

  describe 'creates a new admin' do
    before do
      sign_in admin
      visit console_admins_path
      click_link 'Add Admin'
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
      check 'user_admin'
      check 'user_manager'
      select admin.member.name, from: 'user_member_id'
      click_button 'Save'
      expect(page).to have_content 'The Admin was successfully created!'
      expect(current_path).to eq console_admin_path(User.last)
      expect(User.last.manager).to eq true
      expect(User.last.admin).to eq true
      expect(User.last.member).to eq admin.member
      expect(Member.last.users.count).to eq 2
    end

    it 'unsuccessfully' do
      fill_in 'user_name', with: ''
      click_button 'Save'
      expect(page).to have_content 'Please correct the errors'
      expect(User.count).to eq 1
    end
  end

  describe 'edits an admin' do
    let!(:admin) { create(:user, :admin) }
    let!(:admin_to_edit) { create(:user, :admin, display_name: 'User Admin') }

    before do
      sign_in admin
      visit edit_console_admin_path(admin_to_edit)
    end

    it 'successfully' do
      fill_in 'user_name', with: 'Name Edited'
      click_button 'Save'
      admin_to_edit.reload
      expect(admin_to_edit.name).to eq 'Name Edited'
    end

    it 'unsuccessfully' do
      fill_in 'user_name', with: ''
      click_button 'Save'
      admin_to_edit.reload
      expect(admin_to_edit.name).to_not eq ''
    end
  end

  describe 'deletes an admin' do
    let!(:admin) { create(:user, :admin) }
    let!(:admin_to_edit) { create(:user, :admin, display_name: 'User Admin') }

    before do
      sign_in admin
      visit console_admin_path(admin_to_edit)
    end

    it 'successfully' do
      expect { click_link 'Delete' }.to change{ User.count }.by(-1)
      expect(current_path).to eq console_admins_path
    end
  end

end
