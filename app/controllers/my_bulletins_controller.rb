class MyBulletinsController < ApplicationController
  before_action :find_bulletin, only: [:show, :edit, :update, :destroy]

  def index
    @bulletins = Bulletin.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
  end

  def new
    @bulletin = Bulletin.new
  end

  def create
    @bulletin = Bulletin.new(bulletin_params)
    if @bulletin.save
      redirect_to my_bulletins_path, success: 'The bulletin was successfully created!'
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :new
    end
  end

  def edit
  end

  def update
    if @bulletin.update(bulletin_params)
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
      params.require(:bulletin).permit(:title, :description, :city, :state, :event_date, :event_datetime, :event_type)
    end

    def find_bulletin
      @bulletin = Bulletin.find(params[:id])
    end

end
