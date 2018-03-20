class RenameCustomerToMember < ActiveRecord::Migration[5.2]
  def change
    rename_table :customers, :members
    rename_column :users, :customer_id, :member_id
  end
end
