require 'rails_helper'

RSpec.describe 'News' do

  describe 'visitor' do
    it 'views page successfully' do
      visit news_path
      expect(current_path).to eq news_path
      expect(page).to have_content 'News'
    end
  end

end
