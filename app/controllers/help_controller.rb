class HelpController < ApplicationController
  before_action :require_authentication

  def index
  end

  def new
  end

  def create
    ServiceSupportMailer.notify(params, authenticated_user).deliver_now
    redirect_to help_url, success: "Thank you for your submission. We'll be in touch!"
  end

end
