require 'rails_helper'

RSpec.describe 'Issues pages' do
  let(:member) { create(:member) }
  let(:manager) { create(:user, :manager, member: member) }

  describe 'user' do
    it 'views report issue page successfully' do
      sign_in manager
      visit issues_path

      expect(current_path).to eq issues_path
      expect(page).to have_content 'Issues'
    end

    it 'not logged does not see report issues page' do
      visit issues_path

      expect(current_path).to eq signin_path
      expect(page).to have_content 'You must sign in to continue!'
    end
  end
end
