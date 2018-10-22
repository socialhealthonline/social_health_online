class MyBulletinsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :find_bulletin, only: [:show, :edit, :update, :destroy]

  def index
    @bulletins = Bulletin.where(user_id: authenticated_user.id).order("#{sort_column} #{sort_direction}").page(params[:page]).per(25)
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
      redirect_to my_bulletins_path, success: 'The bulletin was successfully created!'
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :new
    end
  end

  def edit
    if @bulletin.user.id != authenticated_user.id
      redirect_to my_bulletins_path
    else
      render :edit
    end
  end

  def update
    if @bulletin.user.id == authenticated_user.id && @bulletin.update(bulletin_params)
      redirect_to my_bulletins_path, success: 'The bulletin was successfully updated!'
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :edit
    end
  end

  def destroy
    @bulletin.destroy
    redirect_to my_bulletins_path, success: 'The bulletin was successfully deleted!'
  end

  private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :address, :city, :state, :zip, :start_at, :event_date, :location, :event_datetime, :user_id, :display_name, :event_type)
    end

    def find_bulletin
      @bulletin = Bulletin.find(params[:id])
    end

    def sort_column
      %w[title body created_at].include?(params[:column]) ? params[:column] : 'created_at'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
    end

  end
