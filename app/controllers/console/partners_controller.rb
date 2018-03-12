class Console::PartnersController < ConsoleController

  def index
    @partners = Partner.order(:name)
  end

  def show
    @partner = Partner.find params[:id]
  end

  def new
    @partner = Partner.new
  end

  def edit
    @partner = Partner.find params[:id]
  end

  def create
    @partner = Partner.new(partner_params)
    if @partner.save
      redirect_to console_partner_url(@partner), success: 'The partner was successfully created!'
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :new
    end
  end

  def update
    @partner = Partner.find params[:id]
    if @partner.update(partner_params)
      redirect_to console_partner_url(@partner), success: 'The partner was successfully updated!'
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :edit
    end
  end

  def destroy
    @partner = Partner.find params[:id]
    @partner.destroy
    redirect_to console_partners_url, success: 'The partner was successfully deleted!'
  end

  private

  def partner_params
    params.require(:partner).permit(
      :name,
      :address,
      :city,
      :state,
      :zip,
      :phone,
      :url
    )
  end

end
