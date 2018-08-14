class CreateManagerAndSubscriptionService

  attr_reader :flash

  def initialize(member, params)
    @member = member
    @payment_method = params[:payment_method]
    @user_name = params[:manager_name]
    @user_email = params[:manager_email]
    @stripe_token = params[:stripe_token]
    @password = SecureRandom.hex(6)
    @flash = 'Success! Sign-in credentials will be sent to you via email.'
  end

  def call
    create_payment
    self
  end

  private

  def create_payment
    @payment_method.eql?('card') ? card_payment : ach_payment
  end

  def card_payment
    create_customer
    create_subscription if @customer
    make_primary_manager(create_manager)
  end

  def ach_payment
    create_customer
    make_primary_manager(create_manager)
    @flash << ' In 2-3 business days, you’ll receive 2 small (typically less than a dollar) deposits from Social Health in your bank account.' \
              ' Once you receive them, you must confirm your receipt via a verification page to finish the setup process.'
  end

  def create_manager
    User.new.tap do |u|
      u.name = @user_name
      u.email = @user_email
      u.password = @password
      u.member_id = @member.id
      u.manager = true
      u.user_status = :pending
      u.save!(validate: false)
      UserMailer.registration_confirmation(u, @password).deliver
      HiddenField.create(user_id: u.id)
    end
  end

  def make_primary_manager(manager)
    @member.update(primary_manager_id: manager.id)
  end

  def create_customer
    params = { email: @member.contact_email }
    key = @payment_method.eql?('card') ? :card : :source
    params[key] = @stripe_token
    @customer = Stripe::Customer.create(params)
    @member.update!(stripe_customer_id: @customer.id, payment_method: @payment_method.to_sym)
  rescue Stripe::CardError, ActiveRecord::RecordInvalid, Stripe::InvalidRequestError => e
    @member.destroy
    raise e.message
  end

  def create_subscription
    Stripe::Subscription.create({
                                  customer: @customer.id,
                                  items: [
                                    {
                                      plan: @member.plan,
                                      quantity: @member.service_capacity,
                                    },
                                  ]
                                })
  end

end
