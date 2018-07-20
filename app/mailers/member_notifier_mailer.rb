class MemberNotifierMailer < ApplicationMailer
  default from: '"Social Health Online" <support@socialhealthonline.com>'

  def sixty_days_remain(member)
    mail to: member.contact_email, subject: '[Social Health Online] Subscription'
  end
end
