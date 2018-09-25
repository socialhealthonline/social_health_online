class AddWinnerToChallenges < ActiveRecord::Migration[5.2]
  def change
    add_column :challenges, :winner, :string
  end
end
