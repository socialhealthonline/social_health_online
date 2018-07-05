require 'rails_helper'

RSpec.describe 'Contact us' do

  it 'is successful' do
    visit contact_path
    fill_in 'name', with: 'Tom Jones'
    fill_in 'email', with: 'tom@example.com'
    fill_in 'message', with: 'Just a test.'
    click_button 'Send'
    expect(page).to have_content 'Thanks for contacting us'
    expect(current_path).to eq contact_path
    expect(unread_emails_for('sales@socialhealthonline.com').size).to eq 1
  end

end
