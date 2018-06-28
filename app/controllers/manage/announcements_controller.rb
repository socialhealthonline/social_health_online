class Manage::AnnouncementsController < ApplicationController
  before_action :require_manager
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  def index
    @announcements = Announcement.order("#{sort_column} #{sort_direction}").page(params[:page])
    @announcements = Announcement.where(member_id: authenticated_user.member.id).page(params[:page])
  end

  def show; end

  def new
    @announcement = Announcement.new
  end

  def edit; end

  def create
    @announcement = Announcement.new(announcement_params)

    if @announcement.save
      redirect_to manage_announcements_path, success: 'Announcement was successfully created.'
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :new
    end
  end

  def update
    if @announcement.update(announcement_params)
      redirect_to manage_announcements_path, success: 'Announcement was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @announcement.destroy
    redirect_to manage_announcements_path, success: 'Announcement was successfully deleted.'
  end

  private

  def sortable_columns
    %w[
      title body created_at
    ]
  end

  def sort_column
    logger.debug("SORT:::: #{params[:direction].inspect}")
    sortable_columns.include?(params[:column]) ? params[:column] : 'title'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def set_announcement
    @announcement = Announcement.find(params[:id])
  end

  def announcement_params
    params.require(:announcement).permit(:title, :body, :created_at).merge(member_id: authenticated_user.member.id)
  end
end
