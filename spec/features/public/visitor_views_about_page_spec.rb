require 'rails_helper'

RSpec.describe 'About us' do

  describe 'visitor' do
    it 'views page successfully' do
      visit about_us_path
      expect(current_path).to eq about_us_path
      expect(page).to have_content 'About Us'
    end
  end

end
