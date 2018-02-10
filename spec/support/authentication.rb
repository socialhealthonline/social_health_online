require 'rails_helper'

def sign_in(user)
  visit login_path
  fill_in 'email', with: user.email
  fill_in 'password', with: user.password
  click_button 'Log In'
end
