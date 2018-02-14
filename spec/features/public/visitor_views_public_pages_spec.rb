require 'rails_helper'

RSpec.describe 'Public pages' do

  describe 'visitor' do
    it 'views about us page successfully' do
      visit about_us_path
      expect(current_path).to eq about_us_path
      expect(page).to have_content 'About Us'
    end
  end

  describe 'visitor' do
    it 'views join page successfully' do
      visit join_path
      expect(current_path).to eq join_path
      expect(page).to have_content 'Join Up'
    end
  end

  describe 'visitor' do
    it 'views news page successfully' do
      visit news_path
      expect(current_path).to eq news_path
      expect(page).to have_content 'News'
    end
  end

  describe 'visitor' do
    it 'views partners page successfully' do
      visit partners_path
      expect(current_path).to eq partners_path
      expect(page).to have_content 'Our Partners'
    end
  end

  describe 'visitor' do
    it 'views service page successfully' do
      visit service_path
      expect(current_path).to eq service_path
      expect(page).to have_content 'Our Service'
    end
  end

  describe 'visitor' do
    it 'views privacy page successfully' do
      visit privacy_path
      expect(current_path).to eq privacy_path
      expect(page).to have_content 'Privacy Policy'
    end
  end

  describe 'visitor' do
    it 'views terms page successfully' do
      visit terms_path
      expect(current_path).to eq terms_path
      expect(page).to have_content 'Terms'
    end
  end

end
