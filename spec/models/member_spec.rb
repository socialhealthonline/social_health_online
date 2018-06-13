require 'rails_helper'

RSpec.describe Member do

  it { should have_many(:users).dependent(:destroy) }
  it { should have_many(:events).dependent(:destroy) }
  it { should have_many(:announcements).dependent(:destroy) }
  it { should have_one(:primary_manager) }

  it { should validate_presence_of :name }
  it { should validate_presence_of :address }
  it { should validate_presence_of :city }
  it { should validate_presence_of :state }
  it { should validate_presence_of :contact_name }
  it { should validate_presence_of :contact_email }
  it { should validate_presence_of :contact_phone }
  it { should validate_presence_of :phone }
  
  context 'with an existing member' do
    before { create(:member, name: 'Acme') }
    specify do
      should validate_uniqueness_of(:name).case_insensitive
      should_not allow_values('acme', 'ACME').for(:name)
      should allow_value('Some Company Inc').for(:name)
    end
  end

  describe 'valid zip' do
    it { should allow_values('12345', '12345-1234').for(:zip) }
    it { should_not allow_values('abcde', '123', '12345-12', '12345-12345', '12345-ab12').for(:zip) }
  end

  describe 'valid phone number' do
    it { should allow_value('2055551234').for(:contact_phone) }
    it { should allow_value('2055551234').for(:phone) }
    it { should_not allow_values('345645', '20555512342').for(:contact_phone) }
    it { should_not allow_values('345645', '20555512342').for(:phone) }
  end

  describe 'valid US state' do
    it { should allow_value('FL', 'DC').for(:state) }
    it { should_not allow_value('AB').for(:state) }
  end

  describe '#full_address' do
    subject { build(:member, address: '123 Main St', city: 'Hometown', state: 'AL', zip: '35210') }
    specify { expect(subject.full_address).to eq '123 Main St, Hometown, AL, 35210' }
  end

end
