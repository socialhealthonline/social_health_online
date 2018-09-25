class RemoveHideChallengesFromChallenges < ActiveRecord::Migration[5.2]
  def change
    remove_column :challenges, :hide_challenges, :boolean, default: false
  end
end
