require 'rails_helper'

describe AuthenticateUser do
  let(:user) { create(:user, member: create(:member), password: '012345678qwertY', password_confirmation: '012345678qwertY' )  }
  let(:disabled_user) { create(:user, user_status: :disabled, password: '012345678qwertY', password_confirmation: '012345678qwertY', member: create(:member)) }
  let(:params) { { password: '012345678qwertY' } }
  
  describe '#call' do
    context 'successfully authenticate user' do
      let(:authenticate_user) { AuthenticateUser.new(user, params) }
      before { authenticate_user.call }

      it 'successfully authenticate user' do
        expect(authenticate_user.success?).to eq(true)
      end

      it 'successfully authenticate user flash' do
        expect(authenticate_user.flash).to eq("Welcome back, #{user.name}!")
      end
    end

    context 'user was not found' do
      let(:authenticate_user) { AuthenticateUser.new(nil, params) }
      before { authenticate_user.call }

      it 'flash with no user found' do
        expect(authenticate_user.flash).to eq('The email or password you entered was not recognized. Please try again!')
      end
    end

    context 'was found disabled user' do
      let(:authenticate_user) { AuthenticateUser.new(disabled_user, params) }
      before { authenticate_user.call }

      it 'disabled user' do
        expect(disabled_user.disabled?).to eq(true)
      end

      it 'flash with disabled user' do
        expect(authenticate_user.flash).to eq('Your account has been disabled!')
      end
    end
  end
end
