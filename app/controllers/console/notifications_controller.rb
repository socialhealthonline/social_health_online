class Console::NotificationsController < ConsoleController
  before_action :set_notification, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  before_action :require_admin

  def index
    @notifications = Notification.order("#{sort_column} #{sort_direction}").page(params[:page]).per(25)
  end

  def show; end

  def new
    @notification = Notification.new
  end

  def edit; end

  def create
    @notification = Notification.new(notification_params)

    if @notification.save
      redirect_to console_notifications_path, success: 'Notification was successfully created!'
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :new
    end
  end

  def update
    if @notification.update(notification_params)
      redirect_to console_notifications_path, success: 'Notification was successfully updated!'
    else
      render :edit
    end
  end

  def destroy
    @notification.destroy
    redirect_to console_notifications_path, success: 'Notification was successfully deleted!'
  end

  private

    def set_notification
      @notification  = Notification.find(params[:id])
    end

    def notification_params
      params.require(:notification).permit(:title, :body, :special_notification, :created_at)
    end

    def sort_column
      %w[title body special_notification created_at].include?(params[:column]) ? params[:column] : 'created_at'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
    end

end
