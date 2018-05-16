class Manage::SocialTracker::HistoryController < ApplicationController
  def users
    @member = Member.friendly.find params[:name]
    @users = @member.users
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