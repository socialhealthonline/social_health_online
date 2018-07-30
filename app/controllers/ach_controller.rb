class AchController < ApplicationController
  before_action :require_authentication
  skip_before_action :unpaid_user
  skip_before_action :pending_user

  rescue_from Stripe::CardError, Stripe::InvalidRequestError do |e|
    flash[:error] = e.message
    redirect_to edit_ach_path
  end

  def edit
    if authenticated_user.member.ach_verified?
      flash[:warning] = 'Your bank account has already been verified.'
      redirect_to root_path
    end
  end

  def update
    VerifyAchAndCreateSubscriptionService.new(authenticated_user.member, params[:deposit_1], params[:deposit_2]).call
    flash[:success] = 'Success. The charge has been started, you have to wait for it to clear the ACH process.'\
                      'This can take up to 5 business days.'
    redirect_to profile_path
  end

end
