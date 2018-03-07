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
      :password,
      :password_confirmation
    )
  end

end
