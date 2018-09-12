class RemovePeriodoneFromRewards < ActiveRecord::Migration[5.2]
  def change
    remove_column :rewards, :periodone, :string
    remove_column :rewards, :periodtwo, :string
    remove_column :rewards, :periodthree, :string
    remove_column :rewards, :periodfour, :string
    remove_column :rewards, :periodfive, :string
    remove_column :rewards, :month, :string
    remove_column :rewards, :winnersone, :text
    remove_column :rewards, :winnerstwo, :text
    remove_column :rewards, :winnersthree, :text
    remove_column :rewards, :winnersfour, :text
    remove_column :rewards, :winnersfive, :text
  end
end
