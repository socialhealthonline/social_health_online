require 'rails_helper'

feature 'User manage messages', type: :feature, js: true do

  let!(:sender) { create(:user) }
  let!(:recipient) { create(:user, name: 'Alex Ulbricht', display_name: 'Alex') }

  before do
    sign_in sender
    visit mailbox_inbox_path
    click_link 'Compose'
    find('.resipients-box > span').click
    find('input[class=select2-search__field]').send_keys('A')
    find('.select2-results li:not(.loading-results):nth-child(1)').click
    fill_in 'conversation_subject', with: 'Some subject'
    fill_in 'conversation_body', with: 'Some text'
    click_button 'Send'
  end

  it 'redirect to index page after user creates new conversation' do
    expect(current_path).to eq mailbox_inbox_path
  end

  it 'displays a message in list of sent items' do
    click_link 'Sent'
    expect(page).to have_content 'Some subject'
  end

  context 'shows conversation' do
    before do
      visit mailbox_sent_path
      click_link 'View'
    end

    it 'sees his message in conversation' do
      expect(page).to have_content 'Some text'
    end

    it 'sees his answer in conversation' do
      fill_in 'message_body', with: 'Reply text'
      click_on 'Reply'
      expect(page).to have_content 'Reply text'
    end
  end

  context 'adds conversation to trash' do
    before do
      visit mailbox_sent_path
      click_link 'View'
      click_link 'Move to Trash'
      page.driver.browser.switch_to.alert.accept
      visit mailbox_trash_path
    end

    it 'sees conversation in trash' do
      expect(page).to have_content 'Some subject'
    end

    it 'empties trash' do
      click_link 'Empty Trash'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_no_content 'Some subject'
    end
  end
end
