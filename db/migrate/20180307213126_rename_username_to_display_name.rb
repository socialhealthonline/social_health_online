class RenameUsernameToDisplayName < ActiveRecord::Migration[5.2]
  def change
    remove_index :users, :username
    rename_column :users, :username, :display_name
    change_column_null :users, :display_name, true
  end
end
