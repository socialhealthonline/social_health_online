require 'rails_helper'

describe CreateManagerAndSendEmailService do
  let!(:member) { create(:member) }

  before do
    @service = CreateManagerAndSendEmailService.new(member, 'Test user name', 'example@gmail.com')
  end

  describe '#call' do
    context 'Register New User' do
      before do
        @service.call
      end

      it 'send email' do
        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end
    end
  end
end
