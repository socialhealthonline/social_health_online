require 'rails_helper'

RSpec.describe User do

  it { should have_db_index :auth_token }
  it { should have_db_index :customer_id }
  it { should have_db_index :enabled }
  it { should have_db_index :email }
  it { should have_db_index :password_reset_token }

  it { should belong_to :customer }

  it { should have_secure_password }

  describe 'with an existing user' do
    before { create(:user, email: 'george.smith@example.com') }
    specify do
      should validate_uniqueness_of(:email).case_insensitive
      should_not allow_values('george.smith@example.com','GeorGe.SmiTh@example.com').for(:email)
    end
  end

  describe 'required fields' do
    %i(name email address city gender ethnicity birthdate time_zone).each do |field|
      it { should validate_presence_of field }
    end
  end

  describe 'password validation' do
    it { should validate_length_of(:password).is_at_least(8).on(:create).with_message('must be at least 8 characters') }
    it { should_not allow_values('ABCdefgh', '12345678').for(:password) }
    it { should allow_value('ABCd5678').for(:password) }
  end

  describe 'valid email address' do
    it { should_not allow_values('me@example','@example.com','example.com').for(:email) }
    it { should allow_values('me@example.com','ME@example.COM').for(:email) }
  end

  describe 'valid gender' do
    it { should_not allow_values('cat','').for(:gender) }
    it { should allow_values('Female', 'Other', 'Male').for(:gender) }
  end

  describe 'valid ethnicity' do
    it { should_not allow_values('blue','').for(:ethnicity) }
    it { should allow_values('White', 'Black', 'Hispanic').for(:ethnicity) }
  end

  describe 'generates an auth_token on creation' do
    subject { create(:user) }
    specify { expect(subject.auth_token).to_not be_nil }
  end

end
