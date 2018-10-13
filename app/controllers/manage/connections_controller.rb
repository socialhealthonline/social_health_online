class Manage::ConnectionsController < ApplicationController
  before_action :require_manager, only: [:index, :new, :edit, :create, :update, :destroy]
  before_action :set_connection, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  def index
    @connections = Connection.where(member_id: authenticated_user.member.id).order("#{sort_column} #{sort_direction}").page(params[:page]).per(10)
  end

  def show; end

  def new
    @connection = Connection.new
  end

  def edit; end

  def create
    @connection = Connection.new(connection_params)

    if @connection.save
      redirect_to manage_connections_path, success: 'Connection was successfully created!'
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :new
    end
  end

  def update
    if @connection.update(connection_params)
      redirect_to manage_connections_path, success: 'Connection was successfully updated!'
    else
      render :edit
    end
  end

  def destroy
    @connection.destroy
    redirect_to manage_connections_path, success: 'Connection was successfully deleted!'
  end

  private

  def sortable_columns
    %w[name notes url created_at]
  end

  def sort_column
    logger.debug("SORT:::: #{params[:direction].inspect}")
    sortable_columns.include?(params[:column]) ? params[:column] : 'name'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def set_connection
    @connection = Connection.find(params[:id])
  end

  def connection_params
    params.require(:connection).permit(:name, :url, :notes, :created_at).merge(member_id: authenticated_user.member.id)
  end
end
