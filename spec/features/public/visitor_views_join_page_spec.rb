require 'rails_helper'

RSpec.describe 'Join up' do

  describe 'visitor' do
    it 'views page successfully' do
      visit join_path
      expect(current_path).to eq join_path
      expect(page).to have_content 'Join Up'
    end
  end

end
