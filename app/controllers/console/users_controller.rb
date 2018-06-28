class Console::UsersController < ConsoleController
  before_action :load_member
  helper_method :sort_column, :sort_direction

  def index
    @users = User.where(member_id: @member.id).order(:name).page(params[:page]).per(25)
    @users = User.where(member_id: @member.id).order("#{sort_column} #{sort_direction}").page(params[:page]).per(25)
  end

  def show
    @user = User.find params[:id]
  end

  def new
    if @member.users.count < @member.service_capacity
      @user = User.new
    else
      redirect_to console_member_users_url(@member.id), error: 'You have reached your service capacity. If you would like to increase it, please contact us at support@socialhealthonline.com.'
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
      :last_sign_in_at,
      :enabled,
      :manager
    )
  end

  def sortable_columns
    %w[
      name email display_name address city state zip phone gender
      ethnicity birthdate time_zone group last_sign_in_at enabled manager
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
