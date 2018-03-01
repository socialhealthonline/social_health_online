require 'rails_helper'

RSpec.describe 'Admin mananges customer accounts' do

  let!(:admin) { create(:user, :admin) }

  before do
    sign_in admin
    visit console_customers_path
  end

  it 'successfully creates a new customer' do
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
    click_button 'Save'
    expect(page).to have_content 'The customer was successfully created'
    expect(current_path).to eq console_customer_path(Customer.last)
    expect(Customer.count).to eq 1
  end

end
