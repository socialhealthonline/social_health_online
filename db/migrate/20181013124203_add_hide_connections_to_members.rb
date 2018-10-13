class AddHideConnectionsToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :hide_connections, :boolean, default: false
  end
end
