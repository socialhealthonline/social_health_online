class AddLocationToBulletins < ActiveRecord::Migration[5.2]
  def change
    add_column :bulletins, :org_type, :string
  end
end
