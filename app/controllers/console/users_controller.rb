class Console::UsersController < ConsoleController
  before_action :require_admin
  before_action :load_member
  before_action :set_user_status, only: [:create, :update]
  helper_method :sort_column, :sort_direction

  def index
    @users = User.where(member_id: @member.id).order("#{sort_column} #{sort_direction}").page(params[:page])
    @users = FindUsersCommunities.new(@users, show_init_scope: true).call(permitted_params)
    unless @users.kind_of?(Array)
      @users = @users.page(params[:page]).per(25)
    else
      @users = Kaminari.paginate_array(@users).page(params[:page]).per(25)
    end
  end

  def show
    @user = User.find params[:id]
  end

  def new
    if @member.users.count < @member.service_capacity
      @user = User.new
    else
      redirect_to console_member_users_url(@member.id), error: 'You have reached the service capacity.'
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def create
    if @member.users.count < @member.service_capacity
      @user = @member.users.new(user_params)
      @user.set_random_password

      if @user.save
        UserMailer.welcome(@user).deliver_now
        redirect_to console_member_user_url(@member.id, @user), success: 'The User was successfully created!'
      else
        flash.now[:error] = 'Please correct the errors to continue.'
        render :new
      end
    else
      redirect_to console_member_users_url(@member.id), error: 'You have reached your service capacity. If you would like to increase it, please contact us at support@socialhealthonline.com.'
    end
  end

  def update
    @user = User.find params[:id]
    if @user.update(user_params)
      redirect_to console_member_user_url(@member.id, @user), success: 'The User was successfully updated!'
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :edit
    end
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
    redirect_to console_member_users_url(@member.id), success: 'The User was successfully deleted!'
  end

  def export_csv
    csv = helpers.csv_user_list
    send_data csv, filename: "users-#{Date.today}.csv"
  end

  private

  def load_member
    @member = Member.find params[:member_id]
  end

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :display_name,
      :address,
      :city,
      :state,
      :zip,
      :phone,
      :gender,
      :ethnicity,
      :birthdate,
      :time_zone,
      :group,
      :guest,
      :last_sign_in_at,
      :manager,
      :user_status,
      :password,
      :password_confirmation,
      :interest_types,
      :hide_info_on_leaderboard,
      :hide_info_on_user_finder
    )
  end

  def sortable_columns
    %w[
      name email display_name address city state zip phone gender guest
      ethnicity birthdate time_zone group last_sign_in_at user_status=1 manager
    ]
  end

  def sort_column
    logger.debug("SORT:::: #{params[:direction].inspect}")
    sortable_columns.include?(params[:column]) ? params[:column] : 'name'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def set_user_status
    params[:user].merge!(user_status: params[:user][:user_status].to_i).permit!
  end

end
