class CommunitiesController < ApplicationController
  before_action :require_authentication

  def show
    @community = Member.friendly.find params[:id]
  end

end
