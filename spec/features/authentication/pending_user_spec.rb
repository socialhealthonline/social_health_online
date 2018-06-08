require 'rails_helper'

RSpec.describe 'Pending User' do
  describe 'Pending User' do
    let(:user) { create(:user, user_status: :pending) }

    before do
      sign_in user
    end

    it 'redirect to edit profile if user is with status pending' do
      expect(current_path).to eq profile_path
      visit dashboard_path
      expect(current_path).to eq profile_path
    end

    it 'user can navigate over pages' do
      user.update_attribute(:user_status, :activated)
      visit dashboard_path
      expect(current_path).to eq dashboard_path
      visit community_path(user.member)
      expect(current_path).to eq community_path(user.member)
    end
  end
end
