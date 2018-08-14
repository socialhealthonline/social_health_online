class AddEventDatetimeToBulletins < ActiveRecord::Migration[5.2]
  def change
    add_column :bulletins, :event_datetime, :datetime
  end
end
