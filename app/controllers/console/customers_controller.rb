class Console::CustomersController < ConsoleController

  def index
    @customers = Customer.order(:name)
  end

  def show
    @customer = Customer.find params[:id]
  end

  def new
    @customer = Customer.new
  end

  def edit
    @customer = Customer.find params[:id]
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to console_customer_url(@customer), success: 'The customer was successfully created!'
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :new
    end
  end

  def update
    @customer = Customer.find params[:id]
    if @customer.update(customer_params)
      redirect_to console_customer_url(@customer), success: 'The customer was successfully updated!'
    else
      render :edit
    end
  end

  def destroy
    @customer = Customer.find params[:id]
    @customer.destroy
    redirect_to console_customers_url, success: 'The customer was successfully deleted!'
  end

  private

  def customer_params
    params.require(:customer).permit(
      :name,
      :address,
      :city,
      :state,
      :zip,
      :contact_name,
      :contact_email,
      :contact_phone,
      :service_capacity,
      :account_start_date,
      :account_end_date,
      :bio,
      :url,
      :suspended
    )
  end

end
