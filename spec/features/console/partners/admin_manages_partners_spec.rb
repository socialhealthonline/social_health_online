require 'rails_helper'

RSpec.describe 'Admin mananges partners' do

  let!(:admin) { create(:user, :admin) }

  describe 'creates a new partner' do
    before do
      sign_in admin
      visit console_partners_path
    end

    it 'successfully' do
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
  end

  describe 'edits a partner' do
    let!(:partner) { create(:partner) }

    before do
      sign_in admin
      visit edit_console_partner_path(partner)
    end

    it 'successfully' do
      fill_in 'partner_name', with: 'ACME Inc.'
      click_button 'Save'
      partner.reload
      expect(partner.name).to eq 'ACME Inc.'
    end

    it 'unsuccessfully' do
      fill_in 'partner_name', with: ''
      click_button 'Save'
      expect(partner.name).to_not eq ''
    end
  end

  describe 'deletes a partner' do
    let!(:partner) { create(:partner) }

    before do
      sign_in admin
      visit console_partners_path
    end

    it 'successfully' do
      expect { click_link "delete_partner_#{partner.id}" }.to change{ Partner.count }.by(-1)
      expect(current_path).to eq console_partners_path
    end
  end

end
