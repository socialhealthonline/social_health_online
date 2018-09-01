class ConsoleController < ApplicationController
  before_action :require_authentication
  before_action :require_admin
  helper_method :sort_column, :sort_direction

  def index
  end

  def lookups
    @members = Member.all
    @users = User.all.order("#{sort_column} #{sort_direction}")
    @users = FindUsersCommunities.new(@users, show_init_scope: true).call(permitted_params)
    unless @users.kind_of?(Array)
      @users = @users.page(params[:page]).per(20)
    else
      @users = Kaminari.paginate_array(@users).page(params[:page]).per(20)
    end
  end

  private

    def permitted_params
      params.permit(:display_name, :name, :city, :state, :phone, :group, :email, :member_name).reject{|_, v| v.blank?}
    end

    def sort_column
      %w[display_name name city state phone email].include?(params[:column]) ? params[:column] : 'created_at'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
    end
end
