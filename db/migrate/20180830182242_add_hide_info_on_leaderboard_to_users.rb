class AddHideInfoOnLeaderboardToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :hide_info_on_leaderboard, :boolean, default: false
  end
end
