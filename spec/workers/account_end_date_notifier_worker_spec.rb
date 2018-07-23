require 'rails_helper'
RSpec.describe AccountEndDateNotifierWorker, type: :worker do
  describe "#perform_async" do
    it 'enqueues a account end date notifier worker' do
      AccountEndDateNotifierWorker.perform_async
      expect(AccountEndDateNotifierWorker.jobs.size).to eq(1)
    end
  end
end
