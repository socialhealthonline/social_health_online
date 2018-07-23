require 'rails_helper'
require 'stripe_mock'

describe CreateManagerAndSubscriptionService do
  let!(:member) { create(:member) }
  let(:stripe_helper) { StripeMock.create_test_helper }
  let(:payment_params) { stripe_helper.generate_card_token(last4: "2244", exp_month: 33, exp_year: 2255) }
  let(:plan) { stripe_helper.create_plan(id: 'test_plan', amount: 0) }
  before { StripeMock.start }
  after { StripeMock.stop }
  let!(:service) { CreateManagerAndSubscriptionService.new(member,
                                                           manager_name: 'Test user name',
                                                           manager_email: 'example@gmail.com',
                                                           plan: plan.id,
                                                           card_token: payment_params) }
  
  describe '#call' do
    context 'Register New User' do
      it 'send email' do
        expect{ service.call }.to change{ ActionMailer::Base.deliveries.count }.by(1)
      end

      it 'creates new User' do
        expect{ service.call }.to change{ User.count }.by(1)
      end
    end
  end
end
