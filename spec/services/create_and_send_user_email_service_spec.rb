require 'rails_helper'

RSpec.describe CreateAndSendUserEmailService do
  let!(:user) { create(:user, member: create(:member)) }

  before do
    @params = (1..5).map { |i| ["email_#{i}", "user#{i}@gmail.com"] }.to_h
    @service = CreateAndSendUserEmailService.new(@params, user)
  end

  describe '#call' do
    context 'given new users' do
      before do
        @service.call
      end

      it 'sends emails' do
        expect(ActionMailer::Base.deliveries.count).to eq(5)
      end
    end

    context 'given existed users' do
      before do
        @params[:user_6] = 'user1@gmail.com'
        @existed_users = CreateAndSendUserEmailService.new(@params, user).call
      end

      it 'returns an array with already existed user emails' do
        expect(@existed_users).not_to be_empty
      end

      it 'not change email count' do
        expect(ActionMailer::Base.deliveries.count).to eq(5)
      end
    end
  end
end
