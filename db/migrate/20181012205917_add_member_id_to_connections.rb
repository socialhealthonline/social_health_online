class AddMemberIdToConnections < ActiveRecord::Migration[5.2]
  def change
    add_column :connections, :member_id, :bigint
  end
end
