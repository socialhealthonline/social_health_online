require 'rails_helper'

RSpec.describe 'Our Service' do

  describe 'visitor' do
    it 'views page successfully' do
      visit service_path
      expect(current_path).to eq service_path
      expect(page).to have_content 'Our Service'
    end
  end

end
