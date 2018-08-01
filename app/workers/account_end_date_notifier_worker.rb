require 'sidekiq-scheduler'

class AccountEndDateNotifierWorker
  include Sidekiq::Worker

  def perform
    Member.where(period: 'Annual', suspended: false).
      where.not(account_start_date:  nil).
      where.not(account_end_date: nil).
      find_each do |m|
        remain_sixty_days_send_mail(m)
    end
  end

  def remain_sixty_days_send_mail(member)
    if(member.account_end_date - member.account_start_date).to_i == 60
      MemberNotifierMailer.sixty_days_remain(member).deliver
    end
  end
end
