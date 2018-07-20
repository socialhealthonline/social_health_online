class AddPeriodToMember < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :period, :string
    add_index :members, :period
  end
end
