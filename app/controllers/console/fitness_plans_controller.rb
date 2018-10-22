class Console::FitnessPlansController < ConsoleController
  helper_method :sort_column, :sort_direction
  before_action :set_target, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:index, :new, :create, :edit, :update, :destroy]

  def index
    @targets = Target.all.order("#{sort_column} #{sort_direction}").page(params[:page]).per(25)
  end

  def show
  end

  def new
    @target = Target.new
  end

  def create
    @target = Target.new(target_params)
    if @target.save
      redirect_to console_fitness_plans_path, success: 'The fitness plan was successfully created!'
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :new
    end
  end

  def edit
  end

  def update
    if @target.update(target_params)
      redirect_to console_fitness_plans_path, success: 'The fitness plan was successfully updated!'
    else
      render :edit
    end
  end

  def destroy
    @target.destroy
    redirect_to console_fitness_plans_path, success: 'The fitness plan was successfully deleted!'
  end

  private

  def set_target
    @target = Target.find(params[:id])
  end

  def target_params
    params.require(:target).permit(:month, :weekone, :weektwo, :weekthree, :weekfour, :weekfive, :targetone, :targettwo, :targetthree, :targetfour, :targetfive)
  end

  def sort_column
    %w[month created_at].include?(params[:column]) ? params[:column] : 'month'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

end
