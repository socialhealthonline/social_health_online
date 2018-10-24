class AddHideLeaderboardToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :hide_leaderboard, :boolean, default: false
  end
end
