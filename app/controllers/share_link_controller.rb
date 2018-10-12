class ShareLinkController < ApplicationController
  before_action :require_authentication

  def new
  end

  def create
      ShareLinkMailer.notify(params, authenticated_user).deliver_now
      redirect_to home_url, success: 'Shared link successfully sent!'
  end
end
