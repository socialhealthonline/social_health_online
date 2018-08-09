class BulletinsController < ApplicationController
  before_action :require_authentication

  def bulletins
    @bulletins = Bulletin.where("event_date >= ?", Time.zone.now).order(start_at: :desc).page(params[:page])
    @bulletins = FindUsersCommunities.new(@bulletins, show_init_scope: false).call(permitted_params)
  end

  private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :city, :state, :event_date, :event_datetime, :event_type)
    end

    def permitted_params
      params.permit(:state, :city, :zip, :page).reject{|_, v| v.blank?}
    end

    def find_bulletin
      @bulletin = Bulletin.find(params[:id])
    end

end
