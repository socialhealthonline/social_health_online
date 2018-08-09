class CommunitiesController < ApplicationController
  before_action :require_authentication

  def new
  end

  def show
    @member = Member.friendly.find(params[:id]).decorate
    @announcements = @member.announcements.order(created_at: :desc).page(params[:page]).per(10)
    @users = @member.users.all_except(authenticated_user.id).enabled.page(params[:page]).per(10)
  end

  def explore_communities
    @communities = Member.where.not("name = ? ", authenticated_user.member.name).page(params[:page]).per(10)
    @communities = FindUsersCommunities.new(@communities, show_init_scope: false).call(permitted_params)
  end

  def event_search
    @events = Event.where(member_id: authenticated_user.member_id).order(start_at: :desc).page(params[:page]).per(10)
    @events = Event.where("start_at >= ?", Time.zone.now).where(private: false).order(start_at: :desc).page(params[:page])
    @events = FindUsersCommunities.new(@events, show_init_scope: false).call(permitted_params)
  end

  def create
    EventSuggestionsMailer.notify(params, authenticated_user).deliver_now
    redirect_to event_suggestions_url, success: "Thank you for your submission. We'll be in touch!"
  end

  private

    def permitted_params
      params.permit(:state, :city, :zip, :page).reject{|_, v| v.blank?}
    end
end
