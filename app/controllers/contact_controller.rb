class ContactController < ApplicationController

  def new
  end

  def create
    if params[:subject].present? # ignore scripted submissions
      redirect_to contact_url
    elsif verify_recaptcha
      # send email
      ContactMailer.notify(params).deliver_now
      redirect_to contact_url, success: "Thanks for contacting us. We'll be in touch!"
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :new
    end
  end

end
