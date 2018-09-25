class BulletinsController < ApplicationController
  before_action :require_authentication

  def bulletins
    @bulletins = Bulletin.where('start_at > ?', Date.today).all.order(start_at: :desc).page(params[:page])
    @bulletins = FindUsersCommunities.new(@bulletins, show_init_scope: false).call(permitted_params)
    unless @bulletins.kind_of?(Array)
      @bulletins = @bulletins.page(params[:page]).per(10)
    else
      @bulletins = Kaminari.paginate_array(@bulletins).page(params[:page]).per(10)
    end
  end

  private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :address, :start_at, :city, :state, :zip, :user_id, :location, :display_name, :event_date, :event_datetime, :event_type)
    end

    def permitted_params
      params.permit(:state, :city, :page).reject{|_, v| v.blank?}
    end

    def sortable_columns
      %w[
        display_name title city state start_at
      ]
    end

    def sort_column
      logger.debug("SORT:::: #{params[:direction].inspect}")
      sortable_columns.include?(params[:column]) ? params[:column] : 'title'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end
end
