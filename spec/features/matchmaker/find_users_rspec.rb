require 'rails_helper'

RSpec.describe 'Explore Communities' do
  let(:user) { create(:user) }

  before do
    sign_in user
    visit matchmaker_path
  end

  context 'User find community' do
    it_should_behave_like 'searchable user'
  end

  context "User don't find community" do
    it_should_behave_like 'not searchable user'
  end
end
