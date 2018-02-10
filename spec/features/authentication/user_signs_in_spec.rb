require 'rails_helper'

RSpec.describe 'User signs in' do

  describe 'successfully' do
    it 'with redirect from subsequent login_path request' do
      sign_in create(:user)
      expect(page).to have_content('Welcome back')
      expect(current_path).to eq root_path
      visit login_path
      expect(current_path).to eq root_path
    end

    it 'with mixed-case email address' do
      user = create(:user, email: 'TeSt@EXample.com')
      visit login_path
      fill_in 'email', with: 'tEsT@exAMple.com'
      fill_in 'password', with: user.password
      click_button 'Log In'
      user.reload
      expect(current_path).to eq root_path
      expect(page).to have_content('Welcome back')
      expect(user.last_sign_in_at).to_not be nil
    end

    it 'with redirect to an intended url' do
      user = create(:user, :admin)
      visit console_root_path
      expect(current_path).to eq login_path
      expect(page).to have_content 'You must log in to continue'
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
      click_button 'Log In'
      expect(current_path).to eq console_root_path
      expect(page).to have_content('Welcome back')
    end
  end

  describe 'unsuccessfully' do
    let!(:user) { create(:user, email: 'jack@mail.com') }
    before { visit login_path }

    it 'with empty form submission' do
      click_button 'Log In'
      expect(page).to have_content('The email or password you entered was not recognized')
    end

    it 'with incorrect password' do
      fill_in 'email', with: user.email
      fill_in 'password', with: 'nogood'
      click_button 'Log In'
      expect(page).to have_content('The email or password you entered was not recognized')
    end

    it 'with incorrect email' do
      fill_in 'email', with: 'bob@mail.com'
      fill_in 'password', with: user.password
      click_button 'Log In'
      expect(page).to have_content('The email or password you entered was not recognized')
    end

    it 'with disabled user' do
      user.update_attribute(:enabled, false)
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
      click_button 'Log In'
      expect(page).to have_content('Your account has been disabled')
      expect(current_path).to eq '/sessions'
    end
  end

end
