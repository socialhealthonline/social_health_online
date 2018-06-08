require 'rails_helper'

feature 'Member manager updates information', type: :feature do
  let(:member) { create(:member) }
  let(:manager) { create(:user, :manager, member: member) }
  let(:big_image) { File.new("#{Rails.root}/spec/fixtures/files/big_photo.jpg").path }
  let(:txt_file) { File.new("#{Rails.root}/spec/fixtures/files/test.txt").path }
  let(:file_size_error) { 'This file exceeds the maximum allowed file size (3 MB)' }
  let(:file_extension_error) { 'Only image file with extension: .jpg, .jpeg, .gif or .png is allowed' }

  before do
    sign_in manager
    visit manage_edit_member_path
  end

  context 'successfully' do
    before do
      fill_in 'member_address', with: '999 Uptown Ave'
      fill_in 'member_url', with: 'example.com'
      fill_in 'member_bio', with: 'Some bio information.'
      click_button 'Save'
    end

    it 'change address' do
      expect(Member.last.address).to eq '999 Uptown Ave'
    end

    it 'change url' do
      expect(Member.last.url).to eq 'http://example.com'
    end

    it 'change bio' do
      expect(Member.last.bio).to eq 'Some bio information.'
    end

    it 'redirect to edit member path' do
      expect(current_path).to eq manage_edit_member_path
    end

    it 'upload and show image' do
      attach_file('member[logo]', file_fixture('logo.png'))
      click_on 'Save'
      visit community_path(member)
      expect(page).to have_css("img[src*='logo.png']")
    end
  end

  context 'unsuccessfully' do
    before do
      fill_in 'member_name', with: ''
      click_button 'Save'
    end

    it 'change name' do
      expect(Member.last.name).to_not be_nil
    end

    it 'form have field error' do
      expect(page).to have_form_field_error_for('member_name')
    end

    it 'upload big file' do
      attach_file('member[logo]', big_image)
      click_on 'Save'
      expect(page).to have_content(file_size_error)
    end

    it 'upload file with forbidden extension' do
      attach_file('member[logo]', txt_file)
      click_on 'Save'
      expect(page).to have_content(file_extension_error)
    end
  end

  context 'unsuccessfully with frontend validations', js: true do
    it 'upload big file' do
      attach_file('member[logo]', big_image)
      expect(page).to have_content(file_size_error)
    end

    it 'upload file with forbidden extension' do
      attach_file('member[logo]', txt_file)
      expect(page).to have_content(file_extension_error)
    end
  end
end
