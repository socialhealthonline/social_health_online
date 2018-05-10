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

    respond_to do |format|
      format.csv { send_data @member.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end
end