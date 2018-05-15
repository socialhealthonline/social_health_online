require 'rails_helper'

RSpec.describe UserEventRsvpAnswerService do
  before do
    member = create(:member)
    @params = {}
    @params[:event_id] = create(:event, member: member).id
    @params[:event] = 'Yes'
    @authenticated_user = create(:user, member: member)
    @service = UserEventRsvpAnswerService.new(@params, @authenticated_user)
  end

  context "creates rsvp in database" do
    describe 'it creates' do
      it "is successful create" do
        expect { @service.call }.to change { Rsvp.count }.by(1)
      end
    end
  end

  context "updates rsvp in database" do
    describe 'it updates' do
      before do
        @params[:event] = 'No'
        updated_rsvp = UserEventRsvpAnswerService.new(@params, @authenticated_user).call
        @rsvp = Rsvp.last
      end

      it 'is successful update' do
        expect(@rsvp.rsvp_status).to eq @params[:event]
      end
    end
  end
end