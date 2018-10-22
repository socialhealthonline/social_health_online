class Console::RewardsController < ConsoleController
  helper_method :sort_column, :sort_direction
  before_action :set_reward, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:index, :new, :create, :edit, :update, :destroy]

  def index
    @rewards = Reward.all.order("#{sort_column} #{sort_direction}").page(params[:page]).per(25)
  end

  def show
  end

  def new
    @reward = Reward.new
  end

  def create
    @reward = Reward.new(reward_params)
    if @reward.save
      redirect_to console_rewards_path, success: 'The rewards winner was successfully created!'
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :new
    end
  end

  def edit
  end

  def update
    if @reward.update(reward_params)
      redirect_to console_rewards_path, success: 'The rewards winner was successfully updated!'
    else
      render :edit
    end
  end

  def destroy
    @reward.destroy
    redirect_to console_rewards_path, success: 'The rewards winner was successfully deleted!'
  end

  private

  def set_reward
    @reward = Reward.find(params[:id])
  end

  def reward_params
    params.require(:reward).permit(:period, :display_name, :member_name, :state, :prize, :created_at)
  end

  def sort_column
    %w[period display_name member_name state prize].include?(params[:column]) ? params[:column] : 'period'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

end
