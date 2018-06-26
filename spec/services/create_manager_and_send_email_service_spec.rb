require 'rails_helper'

describe CreateManagerAndSendEmailService do
  let!(:member) { create(:member) }
  let!(:service) { CreateManagerAndSendEmailService.new(member, 'Test user name', 'example@gmail.com') }

  describe '#call' do
    context 'Register New User' do
      it 'send email' do
        expect{ service.call }.to change{ ActionMailer::Base.deliveries.count }.by(1)
      end
    end
  end
end
