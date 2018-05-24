class MatchmakersController < ApplicationController
  before_action :require_authentication

  def index
    @users = User.all_except(authenticated_user)
    @users = FindUsersCommunities.new(@users).call(permitted_params)
  end

  private

    def permitted_params
      params.permit(:state, :city, :zip, :page).reject{|_, v| v.blank?}
    end
end
