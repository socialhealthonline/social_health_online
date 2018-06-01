class MatchmakersController < ApplicationController
  before_action :require_authentication

  def index
    @users = User.joins(:hidden_field).matchmaker(authenticated_user)
    @users = FindUsersCommunities.new(@users).call(permitted_params)
  end

  def fetch_user
    @user = User.find(params[:user_id])
    respond_to { |format| format.js }
  end

  private

    def permitted_params
      params.permit(:state, :city, :zip, :page).reject{|_, v| v.blank?}
    end
end
