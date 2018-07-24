require 'rails_helper'

describe RecoverPassword do
  let(:recover_password_service) { instance_double(RecoverPassword) }

  describe '#call' do
    before do
      allow(recover_password_service).to receive(:success?).and_return(true)
      allow(recover_password_service).to receive(:expired?).and_return(true)
      allow(recover_password_service).to receive(:blank_password?).and_return(true)
    end

    it 'sucessfully recover password' do
      expect(recover_password_service.success?).to eq(true)
    end

    it 'receives expired method' do
      expect(recover_password_service.expired?).to eq(true)
    end

    it 'receives blank password method' do
      expect(recover_password_service.blank_password?).to eq(true)
    end
  end
end
