require 'rails_helper'

RSpec.describe 'User signs out' do

  it 'successfully' do
    sign_in create(:user)
    find('#nav-signout').click
    expect(current_path).to eq root_path
  end

end
