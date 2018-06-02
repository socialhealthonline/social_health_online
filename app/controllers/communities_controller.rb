class CommunitiesController < ApplicationController
  before_action :require_authentication

  def show
    @member = Member.friendly.find params[:id]
    @announcements = @member.announcements.page(params[:page])
  end

  def explore_communities
    @communities = Member.where.not("name = ? ", authenticated_user.member.name)
    @communities = FindUsersCommunities.new(@communities).call(permitted_params)
  end

  private

    def permitted_params
      params.permit(:state, :city, :zip, :page).reject{|_, v| v.blank?}
    end
end
