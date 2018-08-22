class ChargeSucceeded
  def call(event)
    invoice = event.data.object
    member = Member.find_by(stripe_customer_id: invoice.customer)
    if member.period
      date = member.period.eql?('Annual') ? 1.year.from_now : 1.month.from_now
      member.update(account_end_date: date)
    end
  end
end
