class Manage::MemberController < ApplicationController
  before_action :require_manager

  def edit
    @member = Member.find authenticated_user.member_id
    @managers = @member.managers
  end

  def update
    @member = Member.find authenticated_user.member_id
    @member.logo.attach(params[:member][:logo]) if params[:member][:logo]
    if @member.update(member_params)
      redirect_to manage_edit_member_url, success: 'Your Community information was successfully updated!'
    else
      @member.logo.purge if @member.errors.messages[:logo].present?
      @managers = @member.managers
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
      :phone,
      :bio,
      :url,
      :events_url,
      :hide_info_on_locator,
      :primary_manager_id,
      :hide_challenges,
      :hide_suggest_events,
      :hide_suggest_announcements,
      :org_type,
      :contact_phone_extension
    )
  end

end
