class AddPublicToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :public_member, :boolean, default: false
  end
end
