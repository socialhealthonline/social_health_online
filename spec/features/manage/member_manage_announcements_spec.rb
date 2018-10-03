require 'rails_helper'

RSpec.describe 'Member manager updates event' do
  let(:member) { create(:member) }
  let(:manager) { create(:user, :manager, member: member) }

  describe 'Member manipulate announcements' do
    before do
      sign_in manager
    end

    it 'successfully enter on the index page' do
      visit community_path(member)
      expect(page).to have_content member.name
      find("a[href='#{manage_announcements_path}']").click
      expect(page).to have_content 'Announcements'
    end
  end

  describe 'creates announcements' do
    before do
      sign_in manager
      visit manage_announcements_path
    end

    context 'when data is correct' do
      before do
        click_link 'Add Announcement'
        fill_in 'announcement_title', with: 'Some title'
        fill_in 'announcement_body', with: 'Some text'
        click_button 'Save'
      end

      it 'render success message' do
        expect(page).to have_content 'Announcement was successfully created!'
      end

      it 'show announcement' do
        expect(page).to have_content Announcement.last.title
      end
    end

    context 'when data is unvalid' do
      it 'render error message' do
        click_link 'Add Announcement'
        click_button 'Save'
        expect(page).to have_content 'Please correct the errors to continue.'
      end
    end
  end

  describe 'edits announcement' do
    let(:announcement) { create(:announcement, member: member) }

    before do
      sign_in manager
      visit edit_manage_announcement_path(announcement)
    end

    it 'successfully' do
      fill_in 'announcement_title', with: 'Awesome title'
      click_button 'Save'
      announcement.reload
      expect(announcement.title).to eq 'Awesome title'
    end

    it 'unsuccessfully' do
      fill_in 'announcement_title', with: ''
      click_button 'Save'
      announcement.reload
      expect(announcement.title).to_not eq ''
    end
  end

  describe 'deletes announcement' do
    let!(:announcement) { create(:announcement, member: member) }

    before do
      sign_in manager
      visit manage_announcements_path
      click_link "delete_announcement_#{announcement.id}"
    end

    context 'successfully' do
      it 'render success message' do
        expect(page).to have_content 'Announcement was successfully deleted!'
      end

      it 'show console index announcement' do
        expect(current_path).to eq manage_announcements_path
      end
    end
  end
end
