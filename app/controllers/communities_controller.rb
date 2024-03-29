class CommunitiesController < ApplicationController
  before_action :require_authentication
  helper_method :sort_column, :sort_direction

  def new_suggest
  end

  def new
  end

  def show
    @member = Member.friendly.find(params[:id]).decorate
    @announcements = @member.announcements.order(created_at: :desc).page(params[:page]).per(10)
    @users = @member.users.order("#{sort_column} #{sort_direction}").enabled.page(params[:user_page]).per(50)
    @users = FindUsersCommunities.new(@users, show_init_scope: true).call(permitted_params)
    unless @users.kind_of?(Array)
      @users = @users.page(params[:user_page]).per(50)
    else
      @users = Kaminari.paginate_array(@users).page(params[:user_page]).per(50)
    end
    @events = Event.where(member_id: @member.id)
             .where("start_at >= ?", Time.zone.now)
             .where(featured_event: true)
             .where(private: false).order(start_at: :asc).page(params[:page]).per(5)
  end

  def leaderboard
    @users = User.where(member_id: authenticated_user.member_id, user_status: :enabled, hide_info_on_leaderboard: false).order("#{sort_column} #{sort_direction}").page(params[:page]).per(50)
  end

  def challenge_index
    @challenges = Challenge.where(member_id: authenticated_user.member_id).order("#{sort_column} #{sort_direction}").page(params[:page]).per(25)
  end

  def connection_index
    @connections = Connection.where(member_id: authenticated_user.member_id).order("#{sort_column} #{sort_direction}").page(params[:page]).per(25)
  end

  def challenge_new
  end

  def challenge_create
    ChallengeCompletedMailer.notify(params, authenticated_user).deliver_now
    redirect_to challenge_new_url, success: "Thank you for your submission. We'll be in touch!"
  end

  def explore_communities
    @communities = Member.where.not("name = ? ", authenticated_user.member.name).where(suspended: false).order(name: :asc)
    @communities = FindUsersCommunities.new(@communities, show_init_scope: false).call(permitted_params)
    unless @communities.kind_of?(Array)
      @communities = @communities.page(params[:page]).per(25)
    else
      @communities = Kaminari.paginate_array(@communities).page(params[:page]).per(25)
    end
  end

  def event_search
    @events = Event.where(member_id: authenticated_user.member_id).order(start_at: :asc)
    @events = Event.where("start_at between ? and ?", Date.today, 90.days.from_now).where(private: false).order(start_at: :asc)
    @events = FindUsersCommunities.new(@events, show_init_scope: false).call(permitted_params)
    unless @events.kind_of?(Array)
      @events = @events.page(params[:page]).per(25)
    else
      @events = Kaminari.paginate_array(@events).page(params[:page]).per(25)
    end
  end

  def create
    EventSuggestionsMailer.notify(params, authenticated_user).deliver_now
    redirect_to event_suggestions_url, success: "Thank you for your submission. We'll be in touch!"
  end

  def create_suggest
    AnnouncementSuggestionsMailer.notify(params, authenticated_user).deliver_now
    redirect_to announcement_suggestions_url, success: "Thank you for your submission. We'll be in touch!"
  end

  private

    def permitted_params
      params.permit(:name, :display_name, :logo, :interest_types, :url, :notes, :completion_date, :state, :city, :location, :created_at, :address, :winner, :prize, :description, :verification_code, :zip, :social_event_logs, :public_member, :challenge_type, :challenge_start_date, :challenge_end_date, :page).reject{|_, v| v.blank?}
    end

    def sortable_columns
      %w[
        name city state public_member title start_at display_name challenge_type challenge_end_date challenge_start_date prize winner notes url
      ]
    end

    def sort_column
      logger.debug("SORT:::: #{params[:direction].inspect}")
      sortable_columns.include?(params[:column]) ? params[:column] : 'created_at'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
    end

    def challenge_params
      params.require(:challenge).permit(:name, :completion_date, :challenge_type, :location, :address, :city, :state, :zip, :verification_code, :winner, :prize, :challenge_start_date, :challenge_end_date, :description, :created_at)
    end
end
