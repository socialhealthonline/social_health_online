require 'rails_helper'

describe AuthenticateUser do
  let(:authenticate_user) { instance_double(AuthenticateUser) }
  let(:disabled_user) { double('user', user_status: :disabled) }

  describe '#call' do
    before do
      allow(authenticate_user).to receive(:success?).and_return(true)
    end

    it 'successfully authenticate user' do
      expect(authenticate_user.success?).to eq(true)
    end

    context 'user was not found' do
      before do
        allow(authenticate_user).to receive(:flash).and_return('The email or password you entered was not recognized. Please try again!')
      end

      it 'flash with no user found' do
        expect(authenticate_user.flash).to eq('The email or password you entered was not recognized. Please try again!')
      end
    end

    context 'was found disabled user' do
      before do
        allow(disabled_user).to receive(:disabled?).and_return(true)
        allow(disabled_user).to receive(:flash).and_return('Your account has been disabled!')
      end

      it 'disabled user' do
        expect(disabled_user.disabled?).to eq(true)
      end

      it 'flash with disabled user' do
        expect(disabled_user.flash).to eq('Your account has been disabled!')
      end
    end
  end
end
