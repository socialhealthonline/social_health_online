class SubscriptionCreated
  def call(event)
    subscription = event.data.object
    member = Member.find_by(stripe_customer_id: subscription.customer)
    if member
      member.update( account_start_date: Time.at(subscription.current_period_start),
                     account_end_date: Time.at(subscription.current_period_end),
                     period: subscription.plan.nickname,
                     suspended: false )
      MemberNotifierMailer.ach_charge_success(member).deliver if member.ach
    end
  end
end
