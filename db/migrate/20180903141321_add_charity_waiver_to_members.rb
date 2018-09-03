class AddCharityWaiverToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :charity_waiver, :boolean, default: false
  end
end
