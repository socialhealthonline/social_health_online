class AffiliatesRegistrationController < ApplicationController

  def new
  end

  def create
    if params[:subject].present?
      redirect_to affiliates_registration_url
    else
      AffiliatesRegistrationMailer.notify(params).deliver_now
      redirect_to affiliates_registration_url, success: "Thank you for interest in becoming and Affiliate. We'll be in touch soon!"
    end
  end
end  

