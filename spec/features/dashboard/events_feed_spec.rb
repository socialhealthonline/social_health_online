require 'rails_helper'

RSpec.describe 'Event feed' do
  let(:user) { create(:user) }
  let(:event) { create(:event, location: 'BJCC', city: 'Hometown', state: 'AL', member: user.member, start_at: Time.current.tomorrow) }
  let(:event_2) { create(:event, title: 'Event Title 2', location: 'BJCC', city: 'Hometown', state: 'AL', member: user.member, start_at: Time.current.yesterday) }
  let!(:rsvp) {create(:rsvp, user: user, event: event)}
  let!(:rsvp_2) {create(:rsvp, user: user, event: event_2)}

  before do
    sign_in user
  end

  context 'An Event is displayed in the feed' do
    it 'Event is on the page then status is yes' do
      visit_page_and_show_event(event)
    end

    it 'Event is on the page then status is maybe' do
      rsvp.update(rsvp_status: 'maybe');
      visit_page_and_show_event(event)
    end
  end

  context 'Do not display event in the feed' do
    it 'Event is NOT on the page then status is no' do
      rsvp.update(rsvp_status: 'no');
      visit_page_and_not_show_event(event)
    end

    it 'Event is not displayed on the page' do
      visit_page_and_not_show_event(event_2)
    end
  end
end
