class ContactController < ApplicationController

  def new
  end

  def create
    if params[:subject].present? # ignore scripted submissions
      redirect_to contact_url
    else
      # send email
      ContactMailer.notify(params).deliver_now
      redirect_to contact_url, success: "Thanks for contacting us. We'll be in touch!"
    end
  end

end
