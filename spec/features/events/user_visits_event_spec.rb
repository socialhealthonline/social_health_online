require 'rails_helper'

RSpec.describe 'User views event' do

  context 'within their community' do
    let!(:user) { create(:user) }
    let!(:event) { create(:event, location: 'BJCC', city: 'Hometown', state: 'AL', member: user.member) }

    before do
      sign_in user
      visit community_event_path(event.member, event)
    end

    it 'is successful' do
      expect(page).to have_content event.title
      expect(page).to have_content event.location_display
    end
  end

  context 'private event outside their community' do
    let!(:user) { create(:user) }
    let!(:event) { create(:event, private: true, member: create(:member)) }

    before do
      sign_in user
      visit community_event_path(event.member, event)
    end

    it 'directed away successfully' do
      expect(current_path).to eq community_path(event.member)
    end
  end

  context 'user go to event' do
    let!(:user) { create(:user) }
    let!(:event) { create(:event, member: create(:member)) }

    before do
      sign_in user
      visit community_event_path(event.member, event)
    end

    it 'is successful subscribe to event' do
      expect(page).to have_content 'RSVP'
      find('#rsvp-dropdown a[href$="yes"]').click
      expect(page).to_not have_content 'The RSVP attendee limit for this event is reached'
    end
  end
end
