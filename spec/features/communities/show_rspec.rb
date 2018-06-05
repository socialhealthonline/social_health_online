require 'rails_helper'

RSpec.describe 'Show page' do
  let!(:member) { create(:member) }
  let(:user) { create(:user, member: member) }
  let!(:event_1) { create(:event, title: 'Event Example1', member: member) }
  let!(:event_2) { create(:event, title: 'Event Example2', member: member, private: true) }

  before do
    sign_in user
    visit community_path(member)
  end

  context 'User see all events' do
    it 'User can see public event' do
      expect(page).to have_content event_1.title
    end

    it 'User can see private event' do
      expect(page).to have_content event_2.title
    end

    it 'User can click on public events and go to their details' do
      click_link event_1.title
      expect(page).to have_content event_1.title
      expect(current_path).to eq community_event_path(member, event_1)
    end
  end

end
