require 'rails_helper'

RSpec.describe 'User updates profile' do

  let!(:user) { create(:user) }

  before do
    sign_in user
    visit profile_path
  end

  it 'successfully' do
    fill_in 'user_name', with: 'Sam Adams III'
    fill_in 'user_email', with: 'SamAdamsIII@example.com'
    fill_in 'profile-password', with: '1qaz2wsx3edc'
    fill_in 'user_password_confirmation', with: '1qaz2wsx3edc'
    click_button 'Update'
    user.reload
    expect(current_path).to eq profile_path
    expect(page).to have_text 'Your profile was successfully updated'
    expect(user.name).to eq 'Sam Adams III'
    expect(user.email).to eq 'samadamsiii@example.com'
  end

  it 'unsuccessfully' do
    fill_in 'user_name', with: ''
    click_button 'Update'
    user.reload
    expect(current_path).to eq '/profile'
    expect(user.name).to_not be_nil
    expect(page).to have_form_field_error_for('user_name')
  end

  it 'unsuccessfully with password update', js: true do
    fill_in 'profile-password', with: 'password'
    click_button 'Update'
    user.reload
    expect(current_path).to eq '/profile'
    expect(page).to have_text 'Must be alphanumeric'
    expect(page).to have_form_field_error_for('profile-password')
    expect(page).to have_text "Doesn't match password"
    expect(page).to have_form_field_error_for('user_password_confirmation')
  end

  it 'successfully update checkbox field user name' do
    uncheck 'user_hidden_field_attributes_name'
    click_button 'Update'
    expect(page).to have_text 'Your profile was successfully updated'
  end

end
