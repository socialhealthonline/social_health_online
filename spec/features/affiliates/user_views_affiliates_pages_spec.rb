require 'rails_helper'

RSpec.describe 'Affiliate pages' do
  let(:member) { create(:member) }
  let(:manager) { create(:user, :manager, member: member) }

  describe 'user' do
    it 'views search page successfully' do
      sign_in manager
      visit affiliates_search_path

      expect(current_path).to eq affiliates_search_path
      expect(page).to have_content 'Affiliate Search'
    end

    it 'not logged does not see affiliate search page' do
      visit affiliates_search_path

      expect(current_path).to eq signin_path
      expect(page).to have_content 'You must sign in to continue!'
    end
  end
end
