class EventReminderController < ApplicationController
  before_action :require_authentication

  def new
  end

  def create
      EventReminderMailer.notify(params, authenticated_user).deliver_now
      redirect_to home_url, success: 'Event reminder successfully sent!'
  end
end
