class UsersRegistrationController < ApplicationController

  def new
  end

  def create
    if params[:subject].present?
      redirect_to users_registration_url
    elsif verify_recaptcha
      UsersRegistrationMailer.notify(params).deliver_now
      redirect_to users_registration_url, success: "Thank you for your interest in becoming a Guest User. We will review your submission and follow up with you soon!"
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :new
    end
  end
end
