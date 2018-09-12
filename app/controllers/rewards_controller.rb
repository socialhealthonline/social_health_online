class RewardsController < ApplicationController
  before_action :require_authentication

  def index
    @rewards = Reward.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  private

  def set_reward
    @reward = Reward.find(params[:id])
  end

  def reward_params
    params.require(:reward).permit(:period, :display_name, :member_name, :state, :prize, :created_at)
  end

end
