class CreateManagerAndSubscriptionService
  def initialize(member, params)
    @member = member
    @user_name = params[:manager_name]
    @user_email = params[:manager_email]
    @plan = params[:plan]
    @card_token = params[:card_token]
    @password = SecureRandom.hex
  end

  def call
    create_subscription
    make_primary_manager(create_manager)
  end

  private

  def create_manager
    User.new.tap do |u|
      u.name = @user_name
      u.email = @user_email
      u.password = @password
      u.member_id = @member.id
      u.manager = true
      u.save!(validate: false)
      UserMailer.registration_confirmation(u, @password).deliver
      HiddenField.create(user_id: u.id)
    end
  end

  def make_primary_manager(manager)
    @member.update(primary_manager_id: manager.id)
  end

  def create_subscription
    customer = Stripe::Customer.create(email: @member.contact_email, card: @card_token)
    if customer
      @member.update!(stripe_customer_id: customer.id)
      Stripe::Subscription.create({
                                                   customer: customer.id,
                                                   items: [
                                                     {
                                                       plan: @plan,
                                                       quantity: @member.service_capacity,
                                                     },
                                                   ],
                                                 })
    end
  rescue Stripe::CardError, ActiveRecord::RecordInvalid => e
    @member.destroy
    raise e.message
  end
end
