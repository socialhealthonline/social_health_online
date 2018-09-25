class MemberNotifierPreview < ActionMailer::Preview

  def charge_reminder
    MemberNotifierMailer.charge_reminder(Member.first)
  end

  def check_ach_deposits
    MemberNotifierMailer.check_ach_deposits(Member.first)
  end

  def ach_charge_success
    MemberNotifierMailer.ach_charge_success(Member.first)
  end

end
