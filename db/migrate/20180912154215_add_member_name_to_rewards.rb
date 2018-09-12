class AddMemberNameToRewards < ActiveRecord::Migration[5.2]
  def change
    add_column :rewards, :member_name, :string
  end
end
