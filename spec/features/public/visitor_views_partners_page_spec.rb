require 'rails_helper'

RSpec.describe 'Partners' do

  describe 'visitor' do
    it 'views page successfully' do
      visit partners_path
      expect(current_path).to eq partners_path
      expect(page).to have_content 'Our Partners'
    end
  end

end
