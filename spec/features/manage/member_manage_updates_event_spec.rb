require 'rails_helper'

RSpec.describe 'Member manager updates event' do
  let(:member) { create(:member) }
  let!(:manager_1) { create(:user, :manager, member: member) }
  let!(:manager_2) { create(:user, :manager, member: member) }
  let!(:event) { create(:event, member: member) }

  context 'rsvp limit validation' do
    let!(:rsvp_1) { create(:rsvp, user: manager_1, event: event)}
    let!(:rsvp_2) { create(:rsvp, user: manager_2, event: event)}

    before do
      sign_in manager_1
    end

    it 'successfully updates event' do
      visit edit_manage_event_path(event)
      expect(page).to have_content 'Edit Event'
      fill_in 'event_title', with: 'Test'
      select('Career/Business', from: 'event_event_type')
      select('California', from: 'event_state')
      fill_in 'event_rsvp_limit', with: 5
      click_button 'Save'
      expect(page).to have_content 'The event was successfully updated!'
    end

    it 'unsuccessfully because validation do not pass' do
      visit edit_manage_event_path(event)
      expect(page).to have_content 'Edit Event'
      fill_in 'event_rsvp_limit', with: 1
      click_button 'Save'
      expect(page).to have_content "Caution - RSVP Limit cannot be less than the number of recorded 'Yes' responses."
    end
  end
end
