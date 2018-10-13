class Manage::ChallengesController < ApplicationController
  before_action :require_manager, only: [:index, :new, :edit, :create, :update, :destroy]
  before_action :set_challenge, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  def index
    @challenges = Challenge.where(member_id: authenticated_user.member.id).order("#{sort_column} #{sort_direction}").page(params[:page]).per(10)
  end

  def show; end

  def new
    @challenge = Challenge.new
  end

  def edit; end

  def create
    @challenge = Challenge.new(challenge_params)

    if @challenge.save
      redirect_to manage_challenges_path, success: 'Challenge was successfully created!'
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :new
    end
  end

  def update
    if @challenge.update(challenge_params)
      redirect_to manage_challenges_path, success: 'Challenge was successfully updated!'
    else
      render :edit
    end
  end

  def destroy
    @challenge.destroy
    redirect_to manage_challenges_path, success: 'Challenge was successfully deleted!'
  end

  private

  def sortable_columns
    %w[name challenge_type challenge_start_date challenge_end_date prize verification_code winner completion_date created_at]
  end

  def sort_column
    logger.debug("SORT:::: #{params[:direction].inspect}")
    sortable_columns.include?(params[:column]) ? params[:column] : 'name'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def set_challenge
    @challenge = Challenge.find(params[:id])
  end

  def challenge_params
    params.require(:challenge).permit(:name, :completion_date, :challenge_type, :location, :address, :city, :state, :zip, :verification_code, :winner, :prize, :challenge_start_date, :challenge_end_date, :description, :created_at).merge(member_id: authenticated_user.member.id)
  end
end
