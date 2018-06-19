class CommunitiesController < ApplicationController
  before_action :require_authentication

  def show
    @member = Member.friendly.find(params[:id]).decorate
    @announcements = @member.announcements.order(created_at: :desc).page(params[:page])
    @users = @member.users.all_except(authenticated_user.id).where(user_status: :activated).page(params[:page]).per(20)
  end

  def explore_communities
    @communities = Member.where.not("name = ? ", authenticated_user.member.name)
    @communities = FindUsersCommunities.new(@communities, show_init_scope: true).call(permitted_params)
  end

  def favorites
  end

  def contacts
  end

  private

    def permitted_params
      params.permit(:state, :city, :zip, :page).reject{|_, v| v.blank?}
    end
end
