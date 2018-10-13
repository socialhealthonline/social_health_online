class AddMemberIdToResources < ActiveRecord::Migration[5.2]
  def change
    add_column :resources, :member_id, :bigint
  end
end
