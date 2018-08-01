class MemberNotifierMailer < ApplicationMailer
  default from: '"Social Health Online" <support@socialhealthonline.com>'

  def sixty_days_remain(member)
    mail to: member.contact_email, subject: '[Social Health Online] Subscription'
  end

  def check_ach_deposits(member)
    mail to: member.contact_email, subject: '[Social Health Online] Check ACH Deposits'
  end

  def ach_charge_success(member)
    mail to: member.contact_email, subject: '[Social Health Online] ACH Payment Succeeded'
  end
end
