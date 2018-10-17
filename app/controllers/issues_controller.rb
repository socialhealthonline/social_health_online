class IssuesController < ApplicationController
  before_action :require_authentication

  def new
  end

  def create
      IssuesMailer.notify(params, authenticated_user).deliver_now
      redirect_to home_url, success: "Thank you for your submission. We'll be in touch!"
  end
end
