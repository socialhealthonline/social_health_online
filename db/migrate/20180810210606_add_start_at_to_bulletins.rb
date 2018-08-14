class AddStartAtToBulletins < ActiveRecord::Migration[5.2]
  def change
    add_column :bulletins, :start_at, :datetime
  end
end
