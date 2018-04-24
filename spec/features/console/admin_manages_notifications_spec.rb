require 'rails_helper'

RSpec.describe 'Admin manages notifications' do

  let(:admin) { create(:user, :admin) }

  describe 'creates notification' do
    before do
      sign_in admin
      visit console_notifications_path
    end

    context 'when data is correct' do
      before do
        click_link 'Add Notification'
        fill_in 'notification_title', with: 'Some title'
        fill_in 'notification_body', with: 'Some text'
        click_button 'Save'
      end

      it 'render success message' do
        expect(page).to have_content 'Notification was successfully created.'
      end

      it 'show notification' do
        expect(current_path).to eq console_notification_path(Notification.last)
      end
    end

    context 'when data is unvalid' do
      it 'render error message' do
        click_link 'Add Notification'
        click_button 'Save'
        expect(page).to have_content 'Please correct the errors to continue.'
      end
    end
  end

  describe 'edits notification' do
    let(:notification) { create(:notification) }

    before do
      sign_in admin
      visit edit_console_notification_path(notification)
    end

    it 'successfully' do
      fill_in 'notification_title', with: 'Awesome title'
      click_button 'Save'
      notification.reload
      expect(notification.title).to eq 'Awesome title'
    end

    it 'unsuccessfully' do
      fill_in 'notification_title', with: ''
      click_button 'Save'
      notification.reload
      expect(notification.title).to_not eq ''
    end
  end

  describe 'deletes notification' do
    let!(:notification) { create(:notification) }

    before do
      sign_in admin
      visit console_notifications_path
      click_link "delete_notification_#{notification.id}"
    end

    context 'successfully' do
      it 'render success message' do
        expect(page).to have_content 'Notification was successfully destroyed.'
      end

      it 'show console index notifications' do
        expect(current_path).to eq console_notifications_path
      end
    end
  end

end
