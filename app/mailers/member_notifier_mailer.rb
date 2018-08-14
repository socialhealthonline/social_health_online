class MemberNotifierMailer < ApplicationMailer
  default from: '"Social Health Online" <support@socialhealthonline.com>'

  def sixty_days_remain(member)
    mail to: member.contact_email, subject: 'Subscription - Social Health Online'
  end

  def check_ach_deposits(member)
    mail to: member.contact_email, subject: 'Check ACH Deposits - Social Health Online'
  end

  def ach_charge_success(member)
    mail to: member.contact_email, subject: 'ACH Payment Succeeded  - Social Health Online'
  end
end
