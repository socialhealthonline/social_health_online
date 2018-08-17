class EventAggregatorsController < ApplicationController
  before_action :require_authentication

  def index
    @resources = Resource.all
    @resources = FindUsersCommunities.new(@resources, show_init_scope: false).call(permitted_params)
      unless @resources.kind_of?(Array)
        @resources = @resources.page(params[:page]).per(10)
      else
        @resources = Kaminari.paginate_array(@resources).page(params[:page]).per(10)
      end
    end

  private

    def permitted_params
      params.permit(:name, :city, :state, :url, :event_type, :page).reject{|_, v| v.blank?}
    end
end
