class Console::FitnessPlansController < ConsoleController
  before_action :set_target, only: [:show, :edit, :update, :destroy]

  def index
    @targets = Target.all.order(created_at: :desc).page(params[:page]).per(10)
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

end
