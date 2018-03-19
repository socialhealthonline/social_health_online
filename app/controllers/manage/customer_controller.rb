class Manage::CustomerController < ApplicationController
  before_action :require_manager

  def edit
    @customer = Customer.find authenticated_user.customer_id
    @managers = User.where(customer_id: authenticated_user.customer_id, manager: true)
  end

  def update
    @customer = Customer.find authenticated_user.customer_id
    if @customer.update(customer_params)
      redirect_to manage_edit_customer_url, success: 'Your community information was successfully updated!'
    else
      @managers = User.where(customer_id: authenticated_user.customer_id, manager: true)
      flash.now[:error] = 'Please correct the errors to continue.'
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(
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
