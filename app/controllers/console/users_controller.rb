class Console::UsersController < ConsoleController
  before_action :load_customer

  def index
    @users = User.where(customer_id: @customer.id).order(:name)
  end

  def show
    @user = User.find params[:id]
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find params[:id]
  end

  def create
    @user = @customer.users.new(user_params)
    @user.set_random_password
    if @user.save
      redirect_to console_customer_user_url(@customer, @user), success: 'The user was successfully created!'
    else
      render :new
    end
  end

  def update
    @user = User.find params[:id]
    if @user.update(user_params)
      redirect_to console_customer_user_url(@customer, @user), success: 'The user was successfully updated!'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
    redirect_to console_customer_users_url(@customer), success: 'The user was successfully deleted!'
  end

  private

  def load_customer
    @customer = Customer.find params[:customer_id]
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
      :enabled,
      :manager
    )
  end

end
