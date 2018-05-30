class MatchmakersController < ApplicationController
  before_action :require_authentication

  def index
    @users = User.joins(:hidden_field).where.not("hidden_fields.user_id = ? and hidden_fields.settings @> ?", authenticated_user.id, { matchmaker: false }.to_json)
    @users = FindUsersCommunities.new(@users).call(permitted_params)
  end

  def fetch_user
    @user = User.find(params[:user_id])
    respond_to do |format|
      format.js
    end
  end

  private

    def permitted_params
      params.permit(:state, :city, :zip, :page).reject{|_, v| v.blank?}
    end
end
