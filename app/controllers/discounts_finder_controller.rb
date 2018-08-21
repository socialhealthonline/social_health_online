class DiscountsFinderController < ApplicationController
  before_action :require_authentication

  def index
    @affiliates = Affiliate.where.not(support_notes: [nil, '']).order(city: :asc)
    @affiliates = FindUsersCommunities.new(@affiliates, show_init_scope: false).call(permitted_params)
      unless @affiliates.kind_of?(Array)
        @affiliates = @affiliates.page(params[:page]).per(10)
      else
        @affiliates = Kaminari.paginate_array(@affiliates).page(params[:page]).per(10)
      end
    end

  private

    def permitted_params
      params.permit(:id, :name, :city, :state, :support_notes, :page).reject{|_, v| v.blank?}
    end

    def sortable_columns
      %w[
        name support_notes city state url
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
