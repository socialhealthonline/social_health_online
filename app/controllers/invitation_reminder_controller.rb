class InvitationReminderController < ApplicationController
  before_action :require_authentication

  def new
  end

  def create
      InvitationReminderMailer.notify(params, authenticated_user).deliver_now
      redirect_to manage_users_path(@user), success: 'Invitation reminder successfully sent!'
  end
end
