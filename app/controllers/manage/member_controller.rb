class Manage::MemberController < ApplicationController
  before_action :require_manager

  def edit
    @member = Member.find authenticated_user.member_id
    @managers = User.where(member_id: authenticated_user.member_id, manager: true)
  end

  def update
    @member = Member.find authenticated_user.member_id
    if @member.update(member_params)
      redirect_to manage_edit_member_url, success: 'Your community information was successfully updated!'
    else
      @managers = User.where(member_id: authenticated_user.member_id, manager: true)
      flash.now[:error] = 'Please correct the errors to continue.'
      render :edit
    end
  end

  private

  def member_params
    params.require(:member).permit(
      :name,
      :address,
      :city,
      :state,
      :zip,
      :bio,
      :url,
      :events_url,
      :primary_manager_id
    )
  end

end
