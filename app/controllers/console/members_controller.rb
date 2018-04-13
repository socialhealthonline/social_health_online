class Console::MembersController < ConsoleController

  def index
    @members = Member.order(:name)
  end

  def show
    @member = Member.find params[:id]
  end

  def new
    @member = Member.new
  end

  def edit
    @member = Member.find params[:id]
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to console_member_url(@member.id), success: 'The member was successfully created!'
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :new
    end
  end

  def update
    @member = Member.find params[:id]
    if @member.update(member_params)
      redirect_to console_member_url(@member.id), success: 'The member was successfully updated!'
    else
      render :edit
    end
  end

  def destroy
    @member = Member.find params[:id]
    @member.destroy
    redirect_to console_members_url, success: 'The member was successfully deleted!'
  end

  private

  def member_params
    params.require(:member).permit(
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
      :events_url,
      :suspended
    )
  end

end
