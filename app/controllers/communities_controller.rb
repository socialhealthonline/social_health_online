class CommunitiesController < ApplicationController
  before_action :require_authentication

  def show
    @member = Member.friendly.find params[:id]
  end

end
