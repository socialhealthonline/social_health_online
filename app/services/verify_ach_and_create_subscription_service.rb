class VerifyAchAndCreateSubscriptionService

  def initialize(member, deposit_1, deposit_2)
    @member = member
    @deposit_1 = to_cents(deposit_1)
    @deposit_2 = to_cents(deposit_2)
  end

  def call
    account = verify_bank_account
    create_subcription if account.status.eql?('verified')
  end

  private

  def verify_bank_account
    @customer_id = @member.stripe_customer_id
    customer = Stripe::Customer.retrieve(@customer_id)
    bank_account = customer.sources.retrieve(customer.default_source)
    bank_account.verify(amounts: [@deposit_1, @deposit_2])

  rescue Stripe::CardError, Stripe::InvalidRequestError => e
    raise e.message
  end

  def create_subcription
    @member.update(ach_verified: true)
    Stripe::Subscription.create({
                                  customer: @customer_id,
                                  items: [
                                    {
                                      plan: @member.plan,
                                      quantity: @member.service_capacity,
                                    },
                                  ]
                                })
  end

  def to_cents(value)
    (value.to_f * 100).round
  end

end
