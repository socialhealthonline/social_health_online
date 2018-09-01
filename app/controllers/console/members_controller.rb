class Console::MembersController < ConsoleController
  helper_method :sort_column, :sort_direction
  before_action :require_admin

  def index
    @members = Member.order("#{sort_column} #{sort_direction}")
    @members = FindUsersCommunities.new(@members, show_init_scope: true).call(permitted_params)
    unless @members.kind_of?(Array)
      @members = @members.page(params[:page]).per(25)
    else
      @members = Kaminari.paginate_array(@members).page(params[:page]).per(25)
    end
  end

  def show
    @member = Member.find params[:id]
  end

  def new
    @member = Member.new
  end

  def edit
    @member = Member.find params[:id]
    @managers = (@member.managers + User.where(admin: true).all).uniq { |u| u.id }
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
    @member.logo.attach(params[:member][:logo]) if params[:member][:logo]
    if @member.update(member_params)
      redirect_to console_member_url(@member.id), success: 'The Member was successfully updated!'
    else
      @member.logo.purge if @member.errors.messages[:logo].present?
      @managers = @member.managers
      flash.now[:error] = 'Please correct the errors to continue.'
      render :edit
    end
  end

  def destroy
    @member = Member.find params[:id]
    @member.destroy
    redirect_to console_members_url, success: 'The Member was successfully deleted!'
  end

  def export_member_csv
    csv = helpers.csv_member_list
    send_data csv, filename: "members-#{Date.today}.csv"
  end

  def export_user_csv
    csv = helpers.csv_user_list
    send_data csv, filename: "users-#{Date.today}.csv"
  end

  def export_global_user_csv
    csv = helpers.csv_global_user_list
    send_data csv, filename: "users-#{Date.today}.csv"
  end

  private

  def permitted_params
    params.permit(:state).reject{|_, v| v.blank?}
  end

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
      :hide_challenges,
      :column,
      :direction,
      :welcome_kit_date,
      :phone,
      :contact_phone_extension,
      :primary_manager_id,
      :hide_suggest_events,
      :public_member,
      :org_type
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

end
