class AddDisplayNameToBulletins < ActiveRecord::Migration[5.2]
  def change
    add_column :bulletins, :display_name, :string
  end
end
