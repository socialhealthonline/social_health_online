class RewardsController < ApplicationController
  before_action :require_authentication
  helper_method :sort_column, :sort_direction

  def index
    @rewards = Reward.all.order("#{sort_column} #{sort_direction}").page(params[:page]).per(10)
  end

  private

  def set_reward
    @reward = Reward.find(params[:id])
  end

  def reward_params
    params.require(:reward).permit(:period, :display_name, :member_name, :state, :prize, :created_at)
  end

  def sort_column
    %w[period display_name member_name state prize].include?(params[:column]) ? params[:column] : 'created_at'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

end
