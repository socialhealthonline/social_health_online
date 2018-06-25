class MembersRegistrationController < ApplicationController

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params)
    if verify_recaptcha(model: @member) && @member.save
      CreateManagerAndSendEmailService.new(@member, params[:member][:account_manager_name], params[:member][:account_manager_email]).call
      flash[:success] = 'Success'
      redirect_to root_path
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :new
    end
  end

  private

  def member_params
    # account_manager_name
    # account_manager_email
    params.require(:member).permit(
      :name,
      :address,
      :city,
      :state,
      :zip,
      :phone,
      :url,
      :contact_name,
      :contact_email,
      :contact_phone,
      :contact_phone_extension,
      :service_capacity,
      :hide_info_on_locator,
      :terms_of_service
    )
  end
end
