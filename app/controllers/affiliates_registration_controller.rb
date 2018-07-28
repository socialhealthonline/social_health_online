class AffiliatesRegistrationController < ApplicationController

  def new
  end

  def create
    if params[:subject].present?
      redirect_to affiliates_registration_url
    elsif verify_recaptcha
      AffiliatesRegistrationMailer.notify(params).deliver_now
      redirect_to affiliates_registration_url, success: "Thank you for your interest in becoming an Affiliate. We will review your submission and follow up with you soon!"
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :new
    end
  end
end
