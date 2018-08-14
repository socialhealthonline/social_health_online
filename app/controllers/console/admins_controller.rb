class Console::AdminsController < ConsoleController
  before_action :set_user_status, only: [:create, :update]
  helper_method :sort_column, :sort_direction

  def index
    @admins = User.where(admin: true).order(:name)
    @admins = @admins.order("#{sort_column} #{sort_direction}").page(params[:page]).per(10)
  end

  def show
    @admin = User.find params[:id]
  end

  def new
    @admin = User.new
    @members = Member.order(:name)
  end

  def edit
    @admin = User.find params[:id]
    @members = Member.order(:name)
  end

  def create
    @admin = User.new(user_params)
    @admin.set_random_password

    if @admin.save
      redirect_to console_admin_url(@admin), success: 'The Admin was successfully created!'
    else
      @members = Member.order(:name)
      flash.now[:error] = 'Please correct the errors to continue.'
      render :new
    end
  end

  def update
    @admin = User.find params[:id]
    if @admin.update(user_params)
      redirect_to console_admin_url(@admin), success: 'The Admin was successfully updated!'
    else
      @members = Member.order(:name)
      flash.now[:error] = 'Please correct the errors to continue.'
      render :edit
    end
  end

  def destroy
    @admin = User.find params[:id]
    @admin.destroy
    redirect_to console_admins_url, success: 'The Admin was successfully deleted!'
  end

  private

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
      :last_sign_in_at,
      :member_id,
      :user_status,
      :manager,
      :admin
    )
  end

  def sortable_columns
    %w[
      name email display_name address city state zip phone gender
      ethnicity birthdate time_zone last_sign_in_at member_id user_status=1 manager
      admin
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
