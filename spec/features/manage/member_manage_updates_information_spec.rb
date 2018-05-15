require 'rails_helper'

RSpec.describe 'Member manager updates information' do

  let!(:manager) { create(:user, :manager, member: create(:member)) }

  before do
    sign_in manager
    visit manage_edit_member_path
  end

  it 'successfully' do
    fill_in 'member_address', with: '999 Uptown Ave'
    fill_in 'member_url', with: 'example.com'
    fill_in 'member_bio', with: 'Some bio information.'
    click_button 'Save'
    expect(Member.last.address).to eq '999 Uptown Ave'
    expect(Member.last.url).to eq 'http://example.com'
    expect(Member.last.bio).to eq 'Some bio information.'
    expect(current_path).to eq manage_edit_member_path
  end

  it 'unsuccessfully' do
    fill_in 'member_name', with: ''
    click_button 'Save'
    expect(Member.last.name).to_not be_nil
    expect(page).to have_form_field_error_for('member_name')
  end
end
