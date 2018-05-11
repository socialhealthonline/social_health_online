class Console::SocialTracker::HistoryController < ConsoleController
  def members
    @members = Member.all
  end

  def users
    @member = Member.friendly.find(params[:name])
    @users  = @member.users
  end

  def user_history
    @member = Member.friendly.find(params[:name])
    @user = User.find(params[:id])
    @social_event_logs = @user.social_event_logs.paginate(page: params[:page],per_page: 2)
  end

  def show
    @member = Member.friendly.find(params[:name])
    @user = User.find(params[:user_id])
    @log = @user.social_event_logs.find(params[:id])
  end

  def member_csv
    @member = Member.friendly.find(params[:name])

    send_data @member.social_tracker_csv, filename: "member-#{@member.friendly_id}-#{Date.today}-social-tracker.csv"
  end
end