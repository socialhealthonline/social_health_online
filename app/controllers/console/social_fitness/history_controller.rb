class Console::SocialFitness::HistoryController < ConsoleController
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
    @social_fitness_logs = @user.social_fitness_logs.paginate(page: params[:page])
  end

  def show
    @member = Member.friendly.find(params[:name])
    @user = User.find(params[:user_id])
    @log = @user.social_fitness_logs.find(params[:id])
  end

  def member_csv
    @member = Member.friendly.find(params[:name])

    send_data @member.social_fitness_csv, filename: "member-#{@member.friendly_id}-#{Date.today}.csv"
  end
end