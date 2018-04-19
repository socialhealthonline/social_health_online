class Console::NotificationsController < ConsoleController
  before_action :set_notification, only: [:show, :edit, :update, :destroy]

  def index
    @notifications = Notification.page(params[:page])
  end

  def show; end

  def new
    @notification = Notification.new
  end

  def edit; end

  def create
    @notification = Notification.new(notification_params)

    if @notification.save
      redirect_to console_notifications_path(@notification), success: 'Notification was successfully created.'
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :new
    end
  end

  def update
    if @notification.update(notification_params)
      redirect_to console_notifications_path(@notifications), success: 'Notification was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @notification.destroy
    redirect_to console_notifications_path, success: 'Notification was successfully destroyed.'
  end

  private

    def set_notification
      @notification = Notification.find(params[:id])
    end

    def notification_params
      params.require(:notification).permit(:title, :body)
    end
end
