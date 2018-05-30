require 'rails_helper'

RSpec.describe 'Admin mananges affiliates' do

  let!(:admin) { create(:user, :admin) }

  describe 'creates a new affiliate' do
    before do
      sign_in admin
      visit console_affiliates_path
    end

    it 'successfully' do
      click_link 'Add Affiliate'
      fill_in 'affiliate_name', with: 'ACME'
      fill_in 'affiliate_address', with: '123 Main St.'
      fill_in 'affiliate_city', with: 'Hometown'
      select 'Alabama', from: 'affiliate_state'
      fill_in 'affiliate_zip', with: '55555'
      fill_in 'affiliate_phone', with: '5555555555'
      fill_in 'affiliate_url', with: 'example.com'
      fill_in 'affiliate_contact_name', with: 'Joel jones'
      fill_in 'affiliate_contact_phone', with: '5555555555'
      fill_in 'affiliate_contact_email', with: 'contact@example.com'
      fill_in 'affiliate_date_added', with: Date.today

      select 'Events', from: 'affiliate_support_type'
      check('affiliate_hide_info_on_locator')
      click_button 'Save'
      expect(page).to have_content 'The affiliate was successfully created'
      expect(current_path).to eq console_affiliate_path(Affiliate.last)
      expect(Affiliate.count).to eq 1
    end
  end

  describe 'edits a affiliate' do
    let!(:affiliate) { create(:affiliate) }

    before do
      sign_in admin
      visit edit_console_affiliate_path(affiliate)
    end

    it 'successfully' do
      fill_in 'affiliate_name', with: 'ACME Inc.'
      click_button 'Save'
      affiliate.reload
      expect(affiliate.name).to eq 'ACME Inc.'
    end

    it 'unsuccessfully' do
      fill_in 'affiliate_name', with: ''
      click_button 'Save'
      expect(affiliate.name).to_not eq ''
    end
  end

  describe 'deletes a affiliate' do
    let!(:affiliate) { create(:affiliate) }

    before do
      sign_in admin
      visit console_affiliates_path
    end

    it 'successfully' do
      expect { click_link "delete_affiliate_#{affiliate.id}" }.to change{ Affiliate.count }.by(-1)
      expect(current_path).to eq console_affiliates_path
    end
  end

end
