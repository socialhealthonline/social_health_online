class ProfileController < ApplicationController
  before_action :require_authentication

  def edit
    @user = authenticated_user
    @hidden_fields = HiddenField.find_or_create_by(user_id: @user.id)
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
      :password_confirmation,
      hidden_field_attributes: [:id, prepared_hidden_fields]
    )
  end

  def prepared_hidden_fields
    authenticated_user.hidden_field.settings.keys.map(&:to_sym)
  end
end
