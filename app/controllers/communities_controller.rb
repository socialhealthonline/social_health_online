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
    @communities = Member.where.not("name = ? ", authenticated_user.member.name)
    @communities = FindUsersCommunities.new(@communities, show_init_scope: false).call(permitted_params)
    unless @communities.kind_of?(Array)
      @communities = @communities.page(params[:page]).per(10)
    else
      @communities = Kaminari.paginate_array(@communities).page(params[:page]).per(10)
    end
  end

  def event_search
    @events = Event.where(member_id: authenticated_user.member_id).order(start_at: :desc)
    @events = Event.where("start_at between ? and ?", Date.today, 90.days.from_now).where(private: false).order(start_at: :desc)
    @events = FindUsersCommunities.new(@events, show_init_scope: false).call(permitted_params)
    unless @events.kind_of?(Array)
      @events = @events.page(params[:page]).per(10)
    else
      @events = Kaminari.paginate_array(@events).page(params[:page]).per(10)
    end
  end

  def create
    EventSuggestionsMailer.notify(params, authenticated_user).deliver_now
    redirect_to event_suggestions_url, success: "Thank you for your submission. We'll be in touch!"
  end

  private

    def permitted_params
      params.permit(:name, :state, :city, :zip, :public_member, :page).reject{|_, v| v.blank?}
    end
end
