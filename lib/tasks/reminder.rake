namespace :reminder do
  desc 'Send notice of charge'
  task charge: :environment do
    puts '--- start reminder:charge task ---'

    Member.where(period: 'Annual', suspended: false).
      where.not(account_start_date:  nil).
      where.not(account_end_date: nil).
      find_each do |m|
      charge_reminder_send_mail(m)
    end
  end

  desc 'Send a deposits check notification'
  task check_ach_deposits: :environment do
    puts '--- start reminder:check_ach_deposits task ---'
    Member.where(payment_method: :ach, ach_verified: false, created_at: 3.days.ago..2.days.ago).find_each do |m|
      MemberNotifierMailer.check_ach_deposits(m).deliver
    end
  end

  def charge_reminder_send_mail(member)
    if(member.account_end_date - member.account_start_date).to_i == 45
      MemberNotifierMailer.charge_reminder(member).deliver
    end
  end
end
