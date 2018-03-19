class AddEventUrlToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :events_url, :string
  end
end
