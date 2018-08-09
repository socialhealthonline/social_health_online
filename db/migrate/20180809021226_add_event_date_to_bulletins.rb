class AddEventDateToBulletins < ActiveRecord::Migration[5.2]
  def change
    add_column :bulletins, :event_date, :date
  end
end
