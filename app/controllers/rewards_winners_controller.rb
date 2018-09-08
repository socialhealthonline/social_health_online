class RewardsWinnersController < ApplicationController
  before_action :require_authentication
  before_action :set_reward, only: [:reward_details]

  def index
    @rewards = Reward.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def reward_details
    render :reward_details
  end

  private

  def set_reward
    @reward = Reward.find(params[:id])
  end

  def reward_params
    params.require(:reward).permit(:month, :source_type, :periodone, :periodtwo, :periodthree, :periodfour, :periodfive, :winnersone, :winnerstwo, :winnersthree, :winnersfour, :winnersfive)
  end

end
