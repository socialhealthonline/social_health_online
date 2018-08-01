require 'sidekiq-scheduler'

class CheckAchDepositsNotifierWorker
  include Sidekiq::Worker

  def perform
    Member.where(payment_method: :ach, ach_verified: false, created_at: 3.days.ago..2.days.ago).find_each do |m|
      MemberNotifierMailer.check_ach_deposits(m).deliver
    end
  end
end
