class Console::SocialFitness::HistoryController < ConsoleController
  helper_method :sort_column, :sort_direction

  def members
    @members = Member.all
    @members = Member.order("#{sort_column} #{sort_direction}")
    @members = FindUsersCommunities.new(@members, show_init_scope: true).call(permitted_params)
    unless @members.kind_of?(Array)
      @members = @members.page(params[:page]).per(25)
    else
      @members = Kaminari.paginate_array(@members).page(params[:page]).per(25)
    end
  end

  def users
    @member = Member.friendly.find(params[:name])
    @users  = @member.users
  end

  def user_history
    @member = Member.friendly.find(params[:name])
    @user = User.find(params[:id])
    @social_fitness_logs = @user.social_fitness_logs.page params[:page]
  end

  def show
    @member = Member.friendly.find(params[:name])
    @user = User.find(params[:user_id])
    @log = @user.social_fitness_logs.find(params[:id])
  end

  def member_csv
    @member = Member.friendly.find(params[:name])

    send_data @member.social_fitness_csv, filename: "member-#{@member.friendly_id}-#{Date.today}-social-fitness.csv"
  end

  def destroy
    # SocialEventLog.destroy(params[:id])
    # redirect_to console_social_tracker_members_path, success:"Log was successfully deleted."
  end

  private

    def permitted_params
      params.permit(:state).reject{|_, v| v.blank?}
    end

    def member_params
      params.require(:member).permit(
        :name,
        :city,
        :state
      )
    end

    def sortable_columns
      %w[name city state]
    end

    def sort_column
      logger.debug("SORT:::: #{params[:direction].inspect}")
      sortable_columns.include?(params[:column]) ? params[:column] : 'name'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end

end
