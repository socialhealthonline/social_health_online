class AddSuspendedStatusToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :suspended, :boolean, default: false, null: false
  end
end
