require 'rails_helper'

RSpec.describe 'Admin mananges partners' do

  let!(:admin) { create(:user, :admin) }

  before do
    sign_in admin
    visit console_partners_path
  end

  it 'successfully creates a new partner' do
    click_link 'Add Partner'
    fill_in 'partner_name', with: 'ACME'
    fill_in 'partner_address', with: '123 Main St.'
    fill_in 'partner_city', with: 'Hometown'
    select 'Alabama', from: 'partner_state'
    fill_in 'partner_zip', with: '55555'
    fill_in 'partner_phone', with: '5555555555'
    fill_in 'partner_url', with: 'example.com'
    click_button 'Save'
    expect(page).to have_content 'The partner was successfully created'
    expect(current_path).to eq console_partner_path(Partner.last)
    expect(Partner.count).to eq 1
  end

  pending 'successfully edits a partner'

end
