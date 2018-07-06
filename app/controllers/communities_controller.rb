class CommunitiesController < ApplicationController
  before_action :require_authentication

  def show
    @member = Member.friendly.find(params[:id]).decorate
    @announcements = @member.announcements.order(created_at: :desc).page(params[:page])
    @users = @member.users.all_except(authenticated_user.id).activated.page(params[:page]).per(20)
  end

  def explore_communities
    @communities = Member.where.not("name = ? ", authenticated_user.member.name)
    @communities = FindUsersCommunities.new(@communities, show_init_scope: true).call(permitted_params)
  end

  def event_search
    @events = Event.where(member_id: authenticated_user.member_id).order(start_at: :desc).page(params[:page]).per(25)
    @events = Event.where("start_at >= ?", Time.zone.now).order(start_at: :desc).page(params[:page])
    @events = FindUsersCommunities.new(@events, show_init_scope: true).call(permitted_params)
  end

  private

    def permitted_params
      params.permit(:state, :city, :zip, :page).reject{|_, v| v.blank?}
    end
end
