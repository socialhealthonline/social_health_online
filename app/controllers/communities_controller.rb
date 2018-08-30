class CommunitiesController < ApplicationController
  before_action :require_authentication
  helper_method :sort_column, :sort_direction

  def new
  end

  def show
    @member = Member.friendly.find(params[:id]).decorate
    @announcements = @member.announcements.order(created_at: :desc).page(params[:page]).per(10)
    @users = @member.users.order("#{sort_column} #{sort_direction}").enabled.page(params[:page]).per(10)
  end

  def leaderboard
    @users = User.where(member_id: authenticated_user.member_id, hide_info_on_leaderboard: false).order("#{sort_column} #{sort_direction}").page(params[:page]).per(10)
  end

  def explore_communities
    @communities = Member.where.not("name = ? ", authenticated_user.member.name).order(city: :asc)
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
      params.permit(:name, :state, :city, :zip, :social_event_logs, :public_member, :page).reject{|_, v| v.blank?}
    end

    def sortable_columns
      %w[
        name city state public_member title start_at display_name
      ]
    end

    def sort_column
      logger.debug("SORT:::: #{params[:direction].inspect}")
      sortable_columns.include?(params[:column]) ? params[:column] : 'name'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
    end
end
