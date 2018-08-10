class AddUserIdToBulletins < ActiveRecord::Migration[5.2]
  def change
    add_column :bulletins, :user_id, :integer
  end
end
