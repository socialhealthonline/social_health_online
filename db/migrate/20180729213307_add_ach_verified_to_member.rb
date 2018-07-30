class AddAchVerifiedToMember < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :ach_verified, :boolean, default: false
  end
end
