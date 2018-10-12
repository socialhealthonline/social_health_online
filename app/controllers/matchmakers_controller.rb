class MatchmakersController < ApplicationController
  before_action :require_authentication

  def index
    @users = FindUsersCommunities.new(User.joins(:hidden_field).matchmaker(authenticated_user), show_init_scope: false).call(permitted_params)
    unless @users.kind_of?(Array)
      @users = @users.page(params[:page]).per(10)
    else
      @users = Kaminari.paginate_array(@users).page(params[:page]).per(10)
    end
  end

  def fetch_user
    @user = User.find(params[:user_id]).decorate
    respond_to { |format| format.js }
  end

  private

    def permitted_params
      params.permit(:state, :display_name, :city, :zip, :interest_types, :page).reject{|_, v| v.blank?}
    end
end
