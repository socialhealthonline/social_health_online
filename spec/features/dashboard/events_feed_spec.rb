require 'rails_helper'

RSpec.describe 'Event feed' do
  let(:user) { create(:user) }
  let(:event) { create(:event, location: 'BJCC', city: 'Hometown', state: 'AL', member: user.member, start_at: Time.current.tomorrow) }
  let(:event_2) { create(:event, title: 'Event Title 2', location: 'BJCC', city: 'Hometown', state: 'AL', member: user.member, start_at: Time.current.yesterday) }
  let!(:rsvp) {create(:rsvp, user: user, event: event)}
  let!(:rsvp_2) {create(:rsvp, user: user, event: event_2)}

  before do
    sign_in user
    visit dashboard_path()
  end

  context 'An Event is displayed in the feed' do
    it 'Event is on the page' do
      expect(page).to have_content event.title
    end
  end

  context 'Do not display event in the feed' do
    it 'Event is not displayed on the page' do
      expect(page).to_not have_content event_2.title
    end
  end
end