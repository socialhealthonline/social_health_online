class AddPeriodToRewards < ActiveRecord::Migration[5.2]
  def change
    add_column :rewards, :period, :string
    add_column :rewards, :display_name, :string
    add_column :rewards, :member_id, :integer
    add_column :rewards, :user_id, :integer
    add_column :rewards, :prize, :string
    add_column :rewards, :state, :string
  end
end
