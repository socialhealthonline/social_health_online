# frozen_string_literal: true

require 'rails_helper'

# helper class to get access to csv_member_list
class MemberCsvHelper
  include MemberHelper
end

RSpec.describe 'Admin manages member accounts' do
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
      fill_in 'member_phone', with: '5555555555'
      fill_in 'member_service_capacity', with: 30
      fill_in 'member_account_start_date', with: Date.today.to_s
      fill_in 'member_url', with: 'example.com'
      fill_in 'member_events_url', with: 'events.example.com'
      check('member_hide_info_on_locator')
      click_button 'Save'
      expect(page).to have_content 'The Member was successfully created'
      expect(current_path).to eq console_member_path(Member.last.id)
      expect(Member.count).to eq 2
    end

    it 'unsuccessfully' do
      click_link 'Add Member'
      fill_in 'member_name', with: 'ACME'
      click_button 'Save'
      expect(Member.count).to eq 1
    end
  end

  describe 'edits a member' do
    let!(:member) { create(:member) }

    before do
      sign_in admin
      visit edit_console_member_path(member.id)
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
      expect { click_link "delete_member_#{member.id}" }.to change { Member.count }.by(-1)
      expect(current_path).to eq console_members_path
    end
  end

  describe 'sort members' do
    FactoryBot.reload
    Member.all.destroy_all

    let!(:members) { create_list(:member, 5) }

    before do
      sign_in admin
      visit console_members_path
    end

    it 'descending' do
      expect(page).to have_selector('table tbody tr:nth-child(1) th', text: 'Member1')

      click_link 'Member Name'

      expect(page).to have_selector('table tbody tr:nth-child(1) th', text: '1. Member6')
    end
  end

  describe 'export members' do
    Member.all.destroy_all
    FactoryBot.reload

    let!(:members) { create_list(:member, 1) }

    before do
      sign_in admin
      visit console_members_path
    end

    it "as csv" do
      click_link 'Export CSV'

      expected_csv = file_fixture('members.csv').read
      generated_csv = MemberCsvHelper.new.csv_member_list

      expect(generated_csv).to eq expected_csv
    end
  end
end
