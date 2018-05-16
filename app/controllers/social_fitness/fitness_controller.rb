class SocialFitness::FitnessController < ApplicationController
  before_action :require_authentication

  def new
    @social_fitness_log = SocialFitnessLog.new
  end

  def create
    @social_fitness_log = authenticated_user.social_fitness_logs.build(log_params)

    if @social_fitness_log.save
      redirect_to social_fitness_history_url, success: 'Fitness logged successfully!'
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :new
    end
  end 

  def index
    @social_fitness_logs = authenticated_user.social_fitness_logs.page params[:page]
  end

  def show
    @log = authenticated_user.social_fitness_logs.find(params[:id])
  end

  private

  def log_params
    params.require(:social_fitness_log).permit(
      :individuals,
      :groups,
      :family,
      :friends,
      :colleagues,
      :significant_other,
      :local_community,
      :overall
    )
  end
end