namespace :run_account_end_date_notifier do
  desc 'Run sidekiq job'
  task account_end_date_notifier: :environment do
    AccountEndDateNotifierWorker.perform_async
  end
end
