require 'rails_helper'
require 'stripe_mock'

describe VerifyAchAndCreateSubscriptionService do
  let(:stripe_helper) { StripeMock.create_test_helper }
  let(:customer) { Stripe::Customer.create({ email: 'bob@app.com', source: stripe_helper.generate_bank_token }) }
  let(:plan) { stripe_helper.create_plan(id: 'test_plan', amount: 0) }
  let(:member) { create(:member, plan: plan.id, stripe_customer_id: customer.id) }
  let(:valid_account) { VerifyAchAndCreateSubscriptionService.new(member, 0.32, 0.45).call }
  before { StripeMock.start }
  after { StripeMock.stop }

  describe 'verify valid account' do
    it 'change member status' do
      valid_account
      expect(member.ach_verified).to eq(true)
    end

    it 'creates subscription' do
      expect(valid_account).to be_an_instance_of(Stripe::Subscription)
    end
  end

end
