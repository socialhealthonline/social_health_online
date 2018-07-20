class SubscriptionCreated
  def call(event)
    invoice = event.data.object
    member = Member.find_by(stripe_customer_id: invoice.customer)
    member.update( account_start_date: Time.at(invoice.current_period_start),
                  account_end_date: Time.at(invoice.current_period_end),
                  period: invoice.plan.nickname,
                  suspended: false ) if member
  end
end
