class ChargeFailed
  def call(event)
    invoice = event.data.object
    member = Member.find_by(stripe_customer_id: invoice.customer)
    member.update(suspended: true) if member
  end
end
