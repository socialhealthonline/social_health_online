class Manage::SocialTracker::HistoryController < ApplicationController
  def users
    @users = User.all
  end

  def user_history
    @user = User.find(params[:id])
    @social_event_logs = @user.social_event_logs.paginate(page: params[:page], per_page: 2)
  end

  def show
    @user = User.find(params[:user_id])
    @log = @user.social_event_logs.find(params[:id])
  end
end