require 'rails_helper'

RSpec.describe 'Admin manages news' do

  let(:admin) { create(:user, :admin) }

  describe 'creates news' do
    before do
      sign_in admin
      visit console_news_index_path
    end

    context 'when data is correct' do
      before do
        click_link 'Add News'
        fill_in 'news_title', with: 'Some title'
        fill_in 'news_body', with: 'Some text'
        click_button 'Save'
      end

      it 'render success message' do
        expect(page).to have_content 'News was successfully created!'
      end

      it 'show news' do
        expect(current_path).to eq console_news_path(News.last)
      end
    end

    context 'when data is unvalid' do
      it 'render error message' do
        click_link 'Add News'
        click_button 'Save'
        expect(page).to have_content 'Please correct the errors to continue.'
      end
    end
  end

  describe 'edits news' do
    let(:news) { create(:news) }

    before do
      sign_in admin
      visit edit_console_news_path(news)
    end

    it 'successfully' do
      fill_in 'news_title', with: 'Awesome title'
      click_button 'Save'
      news.reload
      expect(news.title).to eq 'Awesome title'
    end

    it 'unsuccessfully' do
      fill_in 'news_title', with: ''
      click_button 'Save'
      news.reload
      expect(news.title).to_not eq ''
    end
  end

  describe 'deletes news' do
    let!(:news) { create(:news) }

    before do
      sign_in admin
      visit console_news_index_path
      click_link "delete_news_#{news.id}"
    end

    context 'successfully' do
      it 'render success message' do
        expect(page).to have_content 'News was successfully deleted!'
      end

      it 'show console index news' do
        expect(current_path).to eq console_news_index_path
      end
    end
  end

end
