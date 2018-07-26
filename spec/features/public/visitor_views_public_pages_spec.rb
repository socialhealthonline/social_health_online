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
      expect(page).to have_content 'Joining'
    end
  end

  describe 'visitor' do
    let!(:news) { create(:news, title: 'Test title', body: 'Some text') }

    before do
      visit news_path
    end

    it 'views news page successfully' do
      expect(current_path).to eq news_path
      expect(page).to have_content 'News'
    end

    it 'views news title' do
      expect(page).to have_content 'Test title'
    end

    it 'views news body' do
      expect(page).to have_content 'Some text'
    end
  end

  describe 'visitor' do
    it 'views participation page successfully' do
      visit participation_path
      expect(current_path).to eq participation_path
      expect(page).to have_content 'Participation'
    end
  end

  describe 'visitor' do
    it 'views service page successfully' do
      visit service_path
      expect(current_path).to eq service_path
      expect(page).to have_content 'Service'
    end
  end

  describe 'visitor' do
    it 'views pricing page successfully' do
      visit pricing_path
      expect(current_path).to eq pricing_path
      expect(page).to have_content 'Pricing'
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
