class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip, null: false
      t.string :contact_name, null: false
      t.string :contact_email, null: false
      t.string :contact_phone, null: false
      t.integer :service_capacity, null: false
      t.date :account_start_date
      t.date :account_end_date
      t.timestamps
    end
  end
end
