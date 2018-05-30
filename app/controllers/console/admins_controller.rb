class Console::AdminsController < ConsoleController

  def index
    @admins = User.where(admin: true).order(:name)
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
      :member_id,
      :enabled,
      :manager,
      :admin
    )
  end

end
