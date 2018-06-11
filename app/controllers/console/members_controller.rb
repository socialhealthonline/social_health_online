class Console::MembersController < ConsoleController
  helper_method :sort_column, :sort_direction
  def index
    @members = Member.order("#{sort_column} #{sort_direction}").page(params[:page]).per(25)
  end

  def show
    @member = Member.find params[:id]
  end

  def new
    @member = Member.new
    set_managers_option
  end

  def edit
    @member = Member.find params[:id]
    set_managers_option
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to console_member_url(@member.id), success: 'The Member was successfully created!'
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :new
    end
  end

  def update
    @member = Member.find params[:id]
    if @member.update(member_params)
      redirect_to console_member_url(@member.id), success: 'The Member was successfully updated!'
    else
      render :edit
    end
  end

  def destroy
    @member = Member.find params[:id]
    @member.destroy
    redirect_to console_members_url, success: 'The Member was successfully deleted!'
  end

  def export_csv
    csv = helpers.csv_member_list
    send_data csv, filename: "members-#{Date.today}.csv"
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
      :suspended,
      :hide_info_on_locator,
      :column,
      :direction,
      :welcome_kit_date,
      :phone,
      :contact_phone_extension,
      :primary_manager_id
    )
  end

  def sortable_columns
    %w[
      name address city state zip contact_name contact_email
      contact_phone service_capacity account_start_date account_end_date
      suspended
    ]
  end

  def sort_column
    logger.debug("SORT:::: #{params[:direction].inspect}")
    sortable_columns.include?(params[:column]) ? params[:column] : 'name'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def set_managers_option
    @managers = User.where(member_id: authenticated_user.member_id, manager: true)
  end
end
