class AddEventTypeToBulletins < ActiveRecord::Migration[5.2]
  def change
    add_column :bulletins, :event_type, :string
  end
end
