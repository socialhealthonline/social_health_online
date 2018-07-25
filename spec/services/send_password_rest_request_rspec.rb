require 'rails_helper'

RSpec.describe SendPasswordResetRequest do
  let(:user) { create(:user, member: create(:member)) }
  let(:service) { SendPasswordResetRequest.new(user) }

  describe '#call' do
    context 'given user' do
      it 'should send email' do
        expect{ service.call }.to change{ ActionMailer::Base.deliveries.count }.by(1)
      end
    end
  end
end
