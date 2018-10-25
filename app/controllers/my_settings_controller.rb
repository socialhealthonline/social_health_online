class MySettingsController < ApplicationController
  before_action :require_authentication

  def show; end

  def update
    if authenticated_user.update(settings_params)
      flash[:success] = 'Your settings were successfully updated!'
    else
      flash[:error] = 'Please correct the errors to continue.'
    end
    redirect_to my_settings_path
  end

  private

  def settings_params
    params.require(:user).permit(:receive_email, :hide_info_on_leaderboard, :hide_my_social_events, :hide_my_social_health)
  end

end
