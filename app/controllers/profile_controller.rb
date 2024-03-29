class ProfileController < ApplicationController
  before_action :require_authentication
  skip_before_action :pending_user


  def new
  end

  def create
    RequestDeactivationMailer.notify(params, authenticated_user).deliver_now
    redirect_to home_url, success: "Your account deactivation request has been submitted."
  end

  def edit
    @user = authenticated_user
    HiddenField.find_or_create_by(user_id: @user.id) # move logic of creation then user is creating
  end

  def update
    @user = authenticated_user
    @user.avatar.attach(params[:user][:avatar]) if params[:user][:avatar]
    unless @user.first_login
      params[:user].merge!(first_login: Date.today)
      params[:user].merge!(user_status: :enabled)
    end
    if @user.update(user_params)
      redirect_to home_url, success: 'Your profile was successfully updated!'
    else
      @user.avatar.purge if @user.errors.messages[:avatar].present?
      flash.now[:error] = 'Please correct the errors to continue.'
      render :edit
    end
  end

  private

  def user_params
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
      :hide_info_on_user_finder,
      :group,
      :bio,
      :password,
      :password_confirmation,
      :interest_types,
      :first_login,
      :user_status,
      :phone_extension,
      hidden_field_attributes: [:id, prepared_hidden_fields]
    )
  end

  def prepared_hidden_fields
    authenticated_user.hidden_field.settings.keys.map(&:to_sym)
  end
end
