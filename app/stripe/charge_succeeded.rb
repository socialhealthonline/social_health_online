class ChargeSucceeded
  def call(event)
    invoice = event.data.object
    member = Member.find_by(stripe_customer_id: invoice.customer)
    member.update(suspended: false, account_start_date: Time.current) if member
  end
end
