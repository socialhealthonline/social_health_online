require 'rails_helper'

RSpec.describe 'Admin mananges customers users' do

  let!(:admin) { create(:user, :admin) }
  let!(:customer) { create(:customer) }

  before do
    sign_in admin
    visit console_customer_users_path(customer)
  end

  it 'successfully creates a new user' do
    click_link 'Add User'
    fill_in 'user_name', with: 'Bob Smith'
    fill_in 'user_display_name', with: 'Bobby'
    fill_in 'user_email', with: 'bob@example.com'
    fill_in 'user_phone', with: '5555555555'
    fill_in 'user_address', with: '123 Main St.'
    fill_in 'user_city', with: 'Hometown'
    select 'Alabama', from: 'user_state'
    fill_in 'user_zip', with: '55555'
    select 'Eastern Time (US & Canada)', from: 'user_time_zone'
    fill_in 'user_birthdate', with: '1970-1-1'
    select 'Female', from: 'user_gender'
    select 'Asian', from: 'user_ethnicity'
    click_button 'Save'
    expect(page).to have_content 'The user was successfully created'
    expect(current_path).to eq console_customer_user_path(customer, User.last)
    expect(customer.users.count).to eq 1
  end

  pending 'successfully edits a user'

end
