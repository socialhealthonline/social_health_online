class Manage::UsersController < ApplicationController
  before_action :require_manager
  before_action :set_user, only: [:edit, :update]
  before_action :set_service_capacity, only: [:index, :new]

  def index
    @users = User.where(member_id: authenticated_user.member.id).page(params[:page])
    @users_count = User.all.count
  end

  def new; end

  def edit; end

  def update
    @user_form = Manage::UserForm.new(@user, authenticated_user)
    if @user_form.validate_fields(update_user_params).present?
      flash.now[:error] = @user_form.error
      render :edit
    else
      @user_form.submit(update_user_params)
      redirect_to edit_manage_user_path(@user), success: 'Profile was successfully updated!'
    end
  end

  def create
    users = CreateAndSendUserEmailService.new(user_params, authenticated_user).call
    if users.empty?
      redirect_to manage_users_path, success: 'Successfully send intivations!'
    else
      redirect_to manage_users_path, error: users
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to manage_users_path
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
        :bio,
        :password,
        :password_confirmation,
        :user_status
      )
    end

    def user_params
      params.permit(prepare_emails).reject{|_, v| v.blank?}
    end

    def prepare_emails
      (1..authenticated_user.member.service_capacity).map { |i| "email_#{i}".to_sym}
    end

    def set_user
      @user = User.find(params[:id])
    end

    def set_service_capacity
      @service_capacity = authenticated_user.member.service_capacity
    end
end
