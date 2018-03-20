require 'rails_helper'

RSpec.describe 'Admin mananges member accounts' do

  let!(:admin) { create(:user, :admin) }

  describe 'creates a new member' do
    before do
      sign_in admin
      visit console_members_path
    end

    it 'successfully' do
      click_link 'Add Member'
      fill_in 'member_name', with: 'ACME'
      fill_in 'member_address', with: '123 Main St.'
      fill_in 'member_city', with: 'Hometown'
      select 'Alabama', from: 'member_state'
      fill_in 'member_zip', with: '55555'
      fill_in 'member_contact_name', with: 'Tom Jones'
      fill_in 'member_contact_email', with: 'tom@example.com'
      fill_in 'member_contact_phone', with: '5555555555'
      fill_in 'member_service_capacity', with: 30
      fill_in 'member_account_start_date', with: Date.today.to_s
      fill_in 'member_url', with: 'example.com'
      fill_in 'member_events_url', with: 'events.example.com'
      click_button 'Save'
      expect(page).to have_content 'The member was successfully created'
      expect(current_path).to eq console_member_path(Member.last)
      expect(Member.count).to eq 1
    end

    it 'unsuccessfully' do
      click_link 'Add Member'
      fill_in 'member_name', with: 'ACME'
      click_button 'Save'
      expect(Member.count).to eq 0
    end
  end

  describe 'edits a member' do
    let!(:member) { create(:member) }

    before do
      sign_in admin
      visit edit_console_member_path(member)
    end

    it 'successfully' do
      fill_in 'member_name', with: 'ACME Inc.'
      check 'member_suspended'
      click_button 'Save'
      member.reload
      expect(member.name).to eq 'ACME Inc.'
      expect(member.suspended).to eq true
    end

    it 'unsuccessfully' do
      fill_in 'member_name', with: ''
      click_button 'Save'
      expect(member.name).to_not eq ''
    end
  end

  describe 'deletes a member' do
    let!(:member) { create(:member) }

    before do
      sign_in admin
      visit console_members_path
    end

    it 'successfully' do
      expect { click_link "delete_member_#{member.id}" }.to change{ Member.count }.by(-1)
      expect(current_path).to eq console_members_path
    end
  end

end
