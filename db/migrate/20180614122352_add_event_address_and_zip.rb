class AddEventAddressAndZip < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :address, :string
    add_column :events, :zip, :string
  end
end
