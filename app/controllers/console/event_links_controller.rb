class Console::EventLinksController < ConsoleController
  helper_method :sort_column, :sort_direction
  before_action :find_resource, only: [:show, :edit, :update, :destroy]
  before_action :require_admin

  def index
    @resources = Resource.all.order("#{sort_column} #{sort_direction}")
    @resources = FindUsersCommunities.new(@resources, show_init_scope: true).call(permitted_params)
    unless @resources.kind_of?(Array)
      @resources = @resources.page(params[:page]).per(10)
    else
      @resources = Kaminari.paginate_array(@resources).page(params[:page]).per(10)
    end
  end

  def show
  end

  def new
    @resource = Resource.new
  end

  def create
    @resource = Resource.new(resource_params)
    if @resource.save
      redirect_to console_event_links_path, success: 'The link was successfully created!'
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :new
    end
  end

  def edit
  end

  def update
    if @resource.update(resource_params)
      redirect_to console_event_link_path, success: 'The link was successfully updated!'
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :edit
    end
  end

  def destroy
    @resource.destroy
    redirect_to console_event_links_path, success: 'The link was successfully deleted!'
  end

  private

  def permitted_params
    params.permit(:name, :city, :state).reject{|_, v| v.blank?}
  end

  def resource_params
    params.require(:resource).permit(:name, :event_type, :city, :state, :url)
  end

  def find_resource
    @resource = Resource.find(params[:id])
  end

  def sort_column
    %w[name event_type city state url].include?(params[:column]) ? params[:column] : 'name'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

end
