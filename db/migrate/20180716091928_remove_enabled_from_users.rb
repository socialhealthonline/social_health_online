class RemoveEnabledFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_index :users, :enabled
    remove_column :users, :enabled, :boolean
  end
end
