class IssuesController < ApplicationController
  before_action :require_authentication

  def new
  end

  def create
    if params[:subject].present? # ignore scripted submissions
      redirect_to issues_url
    else
      # send email
      IssuesMailer.notify(params, authenticated_user).deliver_now
      redirect_to issues_url, success: "Thanks for reporting issue(s) us. We'll be in touch!"
    end
  end
end
