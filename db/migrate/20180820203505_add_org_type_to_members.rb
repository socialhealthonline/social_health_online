class AddOrgTypeToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :org_type, :string
  end
end
