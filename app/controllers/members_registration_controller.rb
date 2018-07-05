class MembersRegistrationController < ApplicationController
  rescue_from Stripe::CardError do |e|
    flash.now[:error] = e.message
    render :new
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params.merge(suspended: true))
    if verify_recaptcha(model: @member) && @member.save
      CreateManagerAndSubscriptionService.new(@member,
                                              manager_name: params[:member][:account_manager_name],
                                              manager_email: params[:member][:account_manager_email],
                                              plan: params[:member][:plan],
                                              card_token: stripe_params['stripeToken']).call
      flash[:success] = 'Success'
      redirect_to root_path
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :new
    end
  end

  private

  def stripe_params
    params.permit :stripeToken
  end

  def member_params
    params.require(:member).permit(
      :name,
      :address,
      :city,
      :state,
      :zip,
      :phone,
      :url,
      :contact_name,
      :contact_email,
      :contact_phone,
      :contact_phone_extension,
      :service_capacity,
      :hide_info_on_locator,
      :terms_of_service
    )
  end
end
