class Console::ManageBulletinsController < ConsoleController
  helper_method :sort_column, :sort_direction
  before_action :find_bulletin, only: [:show, :edit, :update, :destroy]

  def index
    @bulletins = Bulletin.all.order("#{sort_column} #{sort_direction}")
    @bulletins = FindUsersCommunities.new(@bulletins, show_init_scope: true).call(permitted_params)
    unless @bulletins.kind_of?(Array)
      @bulletins = @bulletins.page(params[:page]).per(10)
    else
      @bulletins = Kaminari.paginate_array(@bulletins).page(params[:page]).per(10)
    end
  end

  def show
  end

  def new
    @bulletin = Bulletin.new
  end

  def create
    @bulletin = Bulletin.new(bulletin_params)
    @bulletin.user = authenticated_user
    if @bulletin.save
      redirect_to console_manage_bulletins_path, success: 'The bulletin was successfully created!'
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :new
    end
  end

  def edit
    if @bulletin.user.id != authenticated_user.id
      redirect_to console_manage_bulletin_path
    else
      render :edit
    end
  end

  def update
    if @bulletin.update(bulletin_params)
      redirect_to console_manage_bulletin_path, success: 'The bulletin was successfully updated!'
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :edit
    end
  end

  def destroy
    @bulletin.destroy
    redirect_to console_manage_bulletins_path, success: 'The bulletin was successfully deleted!'
  end

  private

  def permitted_params
    params.permit(:state).reject{|_, v| v.blank?}
  end

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :city, :state, :start_at, :user_id, :display_name, :event_date, :event_datetime, :event_type)
  end

  def find_bulletin
    @bulletin = Bulletin.find(params[:id])
  end

  def sort_column
    %w[title city state start_at created_at display_name].include?(params[:column]) ? params[:column] : 'created_at'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

end
