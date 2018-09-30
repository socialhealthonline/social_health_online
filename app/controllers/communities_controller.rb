class CommunitiesController < ApplicationController
  before_action :require_authentication
  helper_method :sort_column, :sort_direction

  def new
  end

  def show
    @member = Member.friendly.find(params[:id]).decorate
    @announcements = @member.announcements.order(created_at: :desc).page(params[:page]).per(10)
    @users = @member.users.order("#{sort_column} #{sort_direction}").enabled.page(params[:page]).per(25)
    @users = FindUsersCommunities.new(@users, show_init_scope: true).call(permitted_params)
    unless @users.kind_of?(Array)
      @users = @users.page(params[:page]).per(25)
    else
      @users = Kaminari.paginate_array(@users).page(params[:page]).per(25)
    end
  end

  def leaderboard
    @users = User.where(member_id: authenticated_user.member_id, user_status: :enabled, hide_info_on_leaderboard: false).order("#{sort_column} #{sort_direction}").page(params[:page]).per(25)
    @users = FindUsersCommunities.new(@users, show_init_scope: true).call(permitted_params)
    unless @users.kind_of?(Array)
      @users = @users.page(params[:page]).per(25)
    else
      @users = Kaminari.paginate_array(@users).page(params[:page]).per(25)
    end
  end

  def challenge_index
    @challenges = Challenge.where(member_id: authenticated_user.member_id).order("#{sort_column} #{sort_direction}").page(params[:page]).per(10)
  end

  def user_finder
    @users = User.where(member_id: authenticated_user.member_id, user_status: :enabled, hide_info_on_user_finder: false).order("#{sort_column} #{sort_direction}").page(params[:page]).per(25)
    @users = FindUsersCommunities.new(@users, show_init_scope: true).call(permitted_params)
    unless @users.kind_of?(Array)
      @users = @users.page(params[:page]).per(25)
    else
      @users = Kaminari.paginate_array(@users).page(params[:page]).per(25)
    end
  end

  def challenge_new
  end

  def challenge_create
    ChallengeCompletedMailer.notify(params, authenticated_user).deliver_now
    redirect_to challenge_new_url, success: "Thank you for your submission. We'll be in touch!"
  end

  def explore_communities
    @communities = Member.where.not("name = ? ", authenticated_user.member.name).where(suspended: false).order(city: :asc)
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
      params.permit(:name, :display_name, :interest_types, :completion_date, :state, :city, :location, :created_at, :address, :winner, :prize, :description, :verification_code, :zip, :social_event_logs, :public_member, :challenge_type, :challenge_start_date, :challenge_end_date, :page).reject{|_, v| v.blank?}
    end

    def sortable_columns
      %w[
        name city state public_member title start_at display_name challenge_type challenge_end_date challenge_start_date prize winner
      ]
    end

    def sort_column
      logger.debug("SORT:::: #{params[:direction].inspect}")
      sortable_columns.include?(params[:column]) ? params[:column] : 'name'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
    end

    def challenge_params
      params.require(:challenge).permit(:name, :completion_date, :challenge_type, :location, :address, :city, :state, :zip, :verification_code, :winner, :prize, :challenge_start_date, :challenge_end_date, :description, :created_at)
    end
end
