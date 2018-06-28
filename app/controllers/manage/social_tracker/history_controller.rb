class Manage::SocialTracker::HistoryController < ApplicationController
  helper_method :sort_column, :sort_direction

  def users
    @member = Member.includes(users: [:social_event_logs]).friendly.find(params[:name])
    @member = Member.where(member_id: @member.id).order("#{sort_column} #{sort_direction}").page(params[:page]).per(25)
  end

  def user_history
    @member = Member.friendly.find params[:name]
    @user = @member.users.find(params[:id])
    @social_event_logs = @user.social_event_logs.page params[:page]
  end

  def show
    @user = @member.users.find(params[:user_id])
    @log = @user.social_event_logs.find(params[:id])
  end
end
