class BulletinsController < ApplicationController
  before_action :require_authentication

  def bulletins
    @bulletins = Bulletin.where('start_at > ?', Date.today).all.page(params[:page])
    @bulletins = FindUsersCommunities.new(@bulletins, show_init_scope: false).call(permitted_params)
  end

  private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :start_at, :city, :state, :user_id, :display_name, :event_date, :event_datetime, :event_type)
    end

    def permitted_params
      params.permit(:state, :city, :zip, :page).reject{|_, v| v.blank?}
    end

    def find_bulletin
      @bulletin = Bulletin.find(params[:id])
    end

end
