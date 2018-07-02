require 'rails_helper'

RSpec.describe 'Explore Communities' do
  let(:user) { create(:user) }

  before do
    sign_in user
    visit explore_communities_path
  end

  context 'User find community' do
    it_should_behave_like 'searchable community'
  end

  context "User don't find community" do
    it_should_behave_like 'not searchable community'
  end
end
