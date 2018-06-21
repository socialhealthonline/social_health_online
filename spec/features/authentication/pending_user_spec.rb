require 'rails_helper'

RSpec.describe 'Pending User' do
  describe 'Pending User' do
    let(:user) { create(:user, user_status: :pending) }

    before do
      sign_in user
    end

    it 'redirect to edit profile if user is with status pending' do
      visit home_path
      expect(current_path).to eq profile_path
    end

    it 'activated user can navigate over pages' do
      user.update_attribute(:user_status, :activated)
      visit home_path
      expect(current_path).to eq home_path
    end
  end
end
