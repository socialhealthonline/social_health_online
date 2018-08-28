class SocialFitness::FitnessController < ApplicationController
  before_action :require_authentication

  def new
    @social_fitness_log = SocialFitnessLog.new
  end

  def create
    @social_fitness_log = authenticated_user.social_fitness_logs.build(log_params)

    if @social_fitness_log.save
      redirect_to social_fitness_history_url, success: 'Entry logged successfully!'
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :new
    end
  end

  def index
    @social_fitness_logs = authenticated_user.social_fitness_logs.page(params[:page]).per(20)
  end

  def show
    @log = authenticated_user.social_fitness_logs.find(params[:id])
  end

  def assets
  end

  def plan
    @targets = Target.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def plan_details
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

  def set_target
    @target = Target.find(params[:id])
  end

  def target_params
    params.require(:target).permit(:month, :weekone, :weektwo, :weekthree, :weekfour, :weekfive, :targetone, :targettwo, :targetthree, :targetfour, :targetfive)
  end

end
