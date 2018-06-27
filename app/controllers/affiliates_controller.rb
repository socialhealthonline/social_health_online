class AffiliatesController < ApplicationController
  before_action :require_authentication
  helper_method :sort_column, :sort_direction

  def index
    @affiliate = Affiliate.order("#{sort_column} #{sort_direction}").page(params[:page])
  end

  def sort_column
    logger.debug("SORT:::: #{params[:direction].inspect}")
    Affiliate::SORTABLE_COLUMNS.include?(params[:column]) ? params[:column] : 'name'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end  
  
end
