class MatchmakersController < ApplicationController
  before_action :require_authentication

  def index
    @users = FindUsersCommunities.new(User.joins(:hidden_field).matchmaker(authenticated_user), show_init_scope: false).call(permitted_params)
  end

  def fetch_user
    @user = User.find(params[:user_id]).decorate
    respond_to { |format| format.js }
  end

  private

    def permitted_params
      params.permit(:state, :display_name, :city, :zip, :page).reject{|_, v| v.blank?}
    end
end
