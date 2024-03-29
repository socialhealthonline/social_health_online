class Manage::SocialTracker::HistoryController < ApplicationController
  before_action :require_manager
  helper_method :sort_column, :sort_direction

  def users
    @member = Member.friendly.find(params[:name])
    @users = User.where(member_id: authenticated_user.member.id).order("#{sort_column} #{sort_direction}").page(params[:page]).per(25)

    if ['name', 'display_name'].include?(params[:column])
      @users = @users.order("#{sort_column} #{sort_direction}").page(params[:page]).per(25)
    end

    if params[:column] == 'last_social_event_log_date'
      @users = @users.sort_by { |u| u.last_social_event_log_date || Time.at(0) }

      if params[:direction] == 'desc'
        @users = @users.reverse
      end
    end

    if params[:column] == 'total_social_events_logged'
      @users = @users.sort_by { |u| u.total_social_events_logged }

      if params[:direction] == 'desc'
        @users = @users.reverse
      end
    end
  end

  def user_history
    @member = Member.friendly.find params[:name]
    @user = @member.users.find(params[:id])
    @social_event_logs = @user.social_event_logs.page(params[:page]).per(25)
  end

  def show
    @user = @member.users.find(params[:user_id])
    @log = @user.social_event_logs.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :display_name,
      :total_social_events_logged,
      :last_social_event_log_date

    )
  end

  def sortable_columns
    %w[
      name display_name total_social_events_logged last_social_event_log_date
    ]
  end

  def sort_column
    logger.debug("SORT:::: #{params[:direction].inspect}")
    sortable_columns.include?(params[:column]) ? params[:column] : 'name'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end


end
