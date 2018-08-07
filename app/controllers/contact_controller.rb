class ContactController < ApplicationController

  def new
  end

  def create
    if verify_recaptcha
      ContactMailer.notify(params).deliver_now
      redirect_to contact_url, success: "Thanks for contacting us. We'll be in touch!"
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :new
    end
  end

end
