require 'rails_helper'

RSpec.describe 'Customer manager updates information' do

  let!(:manager) { create(:user, :manager, customer: create(:customer)) }

  before do
    sign_in manager
    visit manage_edit_customer_path
  end

  it 'successfully' do
    fill_in 'customer_address', with: '999 Uptown Ave'
    fill_in 'customer_url', with: 'example.com'
    fill_in 'customer_bio', with: 'Some bio information.'
    click_button 'Save'
    expect(Customer.last.address).to eq '999 Uptown Ave'
    expect(Customer.last.url).to eq 'http://example.com'
    expect(Customer.last.bio).to eq 'Some bio information.'
    expect(current_path).to eq manage_edit_customer_path
  end

  it 'unsuccessfully' do
    fill_in 'customer_name', with: ''
    click_button 'Save'
    expect(Customer.last.name).to_not be_nil
    expect(page).to have_form_field_error_for('customer_name')
  end

end
