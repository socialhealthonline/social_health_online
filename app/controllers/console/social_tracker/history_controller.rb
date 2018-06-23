class Console::SocialTracker::HistoryController < ConsoleController
  def members
    @members = Member.all
  end

  def users
    @member = Member.friendly.find(params[:name])
    @users = @member.users
  end

  def user_history
    @member = Member.friendly.find(params[:name])
    @user = User.find(params[:id])
    @social_event_logs = @user.social_event_logs.page params[:page]
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

  def destroy
    @log.destroy
    redirect_to console_social_tracker_members_path, success:"Log was successfully deleted."
  end 
  
  
end
