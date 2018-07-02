require 'rails_helper'

describe CreateManagerAndSubscriptionService do
  let!(:member) { create(:member) }
  let!(:service) { CreateManagerAndSubscriptionService.new(member,
                                                           manager_name: 'Test user name',
                                                           manager_email: 'example@gmail.com',
                                                           plan: 'plan_D8hmuJAa05mPhk',
                                                           card_token: '').call }

  describe '#call' do
    context 'Register New User' do
      pending 'need to add stripe_mock'
      # it 'send email' do
      #   expect{ service.call }.to change{ ActionMailer::Base.deliveries.count }.by(1)
      # end
    end
  end
end
