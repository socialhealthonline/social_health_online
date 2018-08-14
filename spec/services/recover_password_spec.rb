require 'rails_helper'

describe RecoverPassword do
  let(:expired_user) { create(:user, member: create(:member), password_reset_sent_at: Time.now - 3.hours) }
  let(:empty_params) { { user: { password: nil } } }
  let(:user) { create(:user, member: create(:member), password_reset_sent_at: Time.now) }
  let(:params) { { user: { password: '012345678qwertY', password_confirmation: '012345678qwertY' } } }

  describe '#call' do
    context 'sucessfully recover password' do
      let(:recover_password) { RecoverPassword.new(user, params) }
      before { recover_password.call }

      it 'succesfully updates password' do
        expect(recover_password.success?).to eq(true)
      end

      it 'has success flash' do
        expect(recover_password.flash).to eq('Your password was successfully changed. Please sign in.')
      end
    end

    context 'receives expired method' do
      let(:recover_password) { RecoverPassword.new(expired_user, params) }
      before { recover_password.call }

      it 'has expired password' do
        expect(recover_password.expired?).to eq(true)
      end

      it 'has expired flash' do
        expect(recover_password.flash).to eq('This password reset request has expired. Please submit another request.')
      end
    end

    context 'receives blank password method' do
      let(:recover_password) { RecoverPassword.new(user, empty_params) }
      before { recover_password.call }

      it 'has blank password' do
        expect(recover_password.blank_password?).to eq(true)
      end

      it 'has expired flash' do
        expect(user.errors.messages[:password].first).to eq("Can't be blank")
      end
    end
  end
end
