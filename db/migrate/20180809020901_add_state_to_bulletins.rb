class AddStateToBulletins < ActiveRecord::Migration[5.2]
  def change
    add_column :bulletins, :state, :string
  end
end
