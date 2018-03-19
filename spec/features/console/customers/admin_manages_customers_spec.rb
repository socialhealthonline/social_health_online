require 'rails_helper'

RSpec.describe 'Admin mananges customer accounts' do

  let!(:admin) { create(:user, :admin) }

  describe 'creates a new customer' do
    before do
      sign_in admin
      visit console_customers_path
    end

    it 'successfully' do
      click_link 'Add Customer'
      fill_in 'customer_name', with: 'ACME'
      fill_in 'customer_address', with: '123 Main St.'
      fill_in 'customer_city', with: 'Hometown'
      select 'Alabama', from: 'customer_state'
      fill_in 'customer_zip', with: '55555'
      fill_in 'customer_contact_name', with: 'Tom Jones'
      fill_in 'customer_contact_email', with: 'tom@example.com'
      fill_in 'customer_contact_phone', with: '5555555555'
      fill_in 'customer_service_capacity', with: 30
      fill_in 'customer_account_start_date', with: Date.today.to_s
      fill_in 'customer_url', with: 'example.com'
      fill_in 'customer_events_url', with: 'events.example.com'
      click_button 'Save'
      expect(page).to have_content 'The customer was successfully created'
      expect(current_path).to eq console_customer_path(Customer.last)
      expect(Customer.count).to eq 1
    end

    it 'unsuccessfully' do
      click_link 'Add Customer'
      fill_in 'customer_name', with: 'ACME'
      click_button 'Save'
      expect(Customer.count).to eq 0
    end
  end

  describe 'edits a customer' do
    let!(:customer) { create(:customer) }

    before do
      sign_in admin
      visit edit_console_customer_path(customer)
    end

    it 'successfully' do
      fill_in 'customer_name', with: 'ACME Inc.'
      check 'customer_suspended'
      click_button 'Save'
      customer.reload
      expect(customer.name).to eq 'ACME Inc.'
      expect(customer.suspended).to eq true
    end

    it 'unsuccessfully' do
      fill_in 'customer_name', with: ''
      click_button 'Save'
      expect(customer.name).to_not eq ''
    end
  end

  describe 'deletes a customer' do
    let!(:customer) { create(:customer) }

    before do
      sign_in admin
      visit console_customers_path
    end

    it 'successfully' do
      expect { click_link "delete_customer_#{customer.id}" }.to change{ Customer.count }.by(-1)
      expect(current_path).to eq console_customers_path
    end
  end

end
