class Manage::UsersController < ApplicationController
  before_action :require_manager
  before_action :check_pending, only: [:update]

  def index
    @users = User.where(member_id: authenticated_user.member.id).page(params[:page])
    @users_count = @users.count
  end

  def new; end

  def edit
    @user = User.find(params[:id])
  end

  def update
    update_user_params[:user_status].downcase!
    @user.attributes = update_user_params
    @user.save(validate: false)
    redirect_to manage_users_path, success: 'Profile was successfully updated!'
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

    def check_pending
      @user = User.find(params[:id])
      if @user.pending? && !update_user_params[:user_status].downcase.eql?('pending')
        render :edit
        flash[:error] = "You can't switch user status"
      end
    end
end
