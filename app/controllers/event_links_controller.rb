class EventLinksController < ApplicationController
  before_action :require_authentication

  def index
    @resources = Resource.all.order(city: :asc)
    @resources = FindUsersCommunities.new(@resources, show_init_scope: false).call(permitted_params)
      unless @resources.kind_of?(Array)
        @resources = @resources.page(params[:page]).per(25)
      else
        @resources = Kaminari.paginate_array(@resources).page(params[:page]).per(25)
      end
    end

  private

    def permitted_params
      params.permit(:name, :city, :state, :url, :notes, :member_id, :event_type, :page).reject{|_, v| v.blank?}
    end

    def sortable_columns
      %w[
        name event_type city state url
      ]
    end

    def sort_column
      logger.debug("SORT:::: #{params[:direction].inspect}")
      sortable_columns.include?(params[:column]) ? params[:column] : 'name'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end
end
