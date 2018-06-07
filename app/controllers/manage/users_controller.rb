class Manage::UsersController < ApplicationController
  before_action :require_manager

  def index
    @users = User.where(member_id: authenticated_user.member.id).page(params[:page])
  end

  def new; end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(update_user_params)
      redirect_to manage_users_path, success: 'Profile was successfully updated!'
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :edit
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
      (1..10).map { |i| "email_#{i}".to_sym}
    end
end
