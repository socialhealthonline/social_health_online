class Console::AffiliatesController < ConsoleController

  def index
    @affiliates = Affiliate.order(:name).page(params[:page]).per(25)
  end

  def show
    @affiliate = Affiliate.find params[:id]
  end

  def new
    @affiliate = Affiliate.new
  end

  def edit
    @affiliate = Affiliate.find params[:id]
  end

  def create
    @affiliate = Affiliate.new(affiliate_params)
    if @affiliate.save
      redirect_to console_affiliate_url(@affiliate), success: 'The Affiliate was successfully created!'
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :new
    end
  end

  def update
    @affiliate = Affiliate.find params[:id]
    if @affiliate.update(affiliate_params)
      redirect_to console_affiliate_url(@affiliate), success: 'The Affiliate was successfully updated!'
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :edit
    end
  end

  def destroy
    @affiliate = Affiliate.find params[:id]
    @affiliate.destroy
    redirect_to console_affiliates_url, success: 'The Affiliate was successfully deleted!'
  end

  private

  def affiliate_params
    params.require(:affiliate).permit(
      :name,
      :address,
      :city,
      :state,
      :zip,
      :phone,
      :url,
      :hide_info_on_locator,
      :support_type,
      :contact_name,
      :contact_phone,
      :contact_phone_extension,
      :contact_email,
      :support_notes,
      :date_added
    )
  end

end
