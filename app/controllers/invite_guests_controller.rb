class InviteGuestsController < ApplicationController
  before_action :require_authentication

  def new
  end

  def create
      InviteGuestsMailer.notify(params, authenticated_user).deliver_now
      redirect_to invite_guests_url, success: 'Invitation successfully sent!'
  end
end
