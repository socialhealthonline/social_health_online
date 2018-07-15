class AffiliatesRegistrationController < ApplicationController

  def new
  end

  def create
    if params[:subject].present?
      redirect_to affiliates_registration_url
    else
      AffiliatesRegistrationMailer.notify(params).deliver_now
      redirect_to affiliates_registration_url, success: "Thank you for your interest in becoming an Affiliate. We will review your submission within one week. We will follow up with you soon!"
    end
  end
end
