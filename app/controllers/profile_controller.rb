class ProfileController < ApplicationController
  before_action :require_authentication

  def edit
    @user = authenticated_user
  end

  def update
    @user = authenticated_user
    if @user.update(user_params)
      redirect_to profile_url, success: 'Your profile was successfully updated!'
    else
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
      :bio,
      :password,
      :password_confirmation
    )
  end

end
