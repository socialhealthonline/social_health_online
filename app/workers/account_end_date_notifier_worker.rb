require 'sidekiq-scheduler'

class AccountEndDateNotifierWorker
  include Sidekiq::Worker

  def perform
    Member.where(period: 'Annual', suspended: false).
      where.not(account_start_date:  nil).
      where.not(account_end_date: nil).
      find_each do |m|
        charge_reminder_send_mail(m)
    end
  end

  def charge_reminder_send_mail(member)
    if(member.account_end_date - member.account_start_date).to_i == 45
      MemberNotifierMailer.charge_reminder(member).deliver
    end
  end
end
