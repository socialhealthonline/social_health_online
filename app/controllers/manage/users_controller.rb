class Manage::UsersController < ApplicationController
  before_action :require_manager
  before_action :set_user, only: [:edit, :update]
  before_action :set_service_capacity, only: [:index, :new]
  before_action :set_user_count, only: [:index, :new]
  helper_method :sort_column, :sort_direction

  def index
    @users = User.where(member_id: authenticated_user.member.id).order("#{sort_column} #{sort_direction}").page(params[:page]).per(25).decorate
  end

  def new
    @available_users_count = @service_capacity - @users_count
  end

  def edit; end

  def update
    @user_form = Manage::UserForm.new(@user, authenticated_user)
    if @user_form.validate_fields(update_user_params).present?
      flash.now[:error] = @user_form.error
      render :edit
    else
      @user_form.submit(update_user_params)
      redirect_to manage_users_path(@user), success: 'Profile was successfully updated!'
    end
  end

  def create
    users = CreateAndSendUserEmailService.new(user_params, authenticated_user).call
    if users.empty?
      redirect_to manage_users_path, success: 'Invitation(s) successfully sent!'
    else
      redirect_to manage_users_path, error: users
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to manage_users_path
  end

  def export_user_csv
    csv = helpers.csv_member_user_list
    send_data csv, filename: "users-#{Date.today}.csv"
  end

  private

  def update_user_params
    params.require(:user).permit(
      :name,
      :display_name,
      :email,
      :phone,
      :address,
      :city,
      :state,
      :zip,
      :time_zone,
      :birthdate,
      :gender,
      :ethnicity,
      :relationship_status,
      :education_level,
      :occupation,
      :languages,
      :hobbies,
      :pet_peeves,
      :group,
      :bio,
      :password,
      :password_confirmation,
      :manager,
      :user_status,
      :hide_info_on_leaderboard
    )
  end

  def sortable_columns
    %w[
      name display_name email group user_status manager
    ]
  end

  def sort_column
    logger.debug("SORT:::: #{params[:direction].inspect}")
    sortable_columns.include?(params[:column]) ? params[:column] : 'name'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def user_params
    params.permit(prepare_emails).reject{|_, v| v.blank?}
  end

  def prepare_emails
    (1..authenticated_user.member.service_capacity).map { |i| "email_#{i}".to_sym}
  end

  def set_user
    @user = User.find(params[:id]).decorate
  end

  def set_service_capacity
    @service_capacity = authenticated_user.member.service_capacity
  end

  def set_user_count
    @users_count = User.where(member_id: authenticated_user.member.id).count
  end
end
