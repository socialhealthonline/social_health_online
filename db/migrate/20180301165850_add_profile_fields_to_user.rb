class AddProfileFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string, null: false
    add_column :users, :address, :string, null: false
    add_column :users, :city, :string, null: false
    add_column :users, :state, :string, null: false
    add_column :users, :zip, :string, null: false
    add_column :users, :phone, :string, null: false
    add_column :users, :gender, :string, null: false
    add_column :users, :ethnicity, :string, null: false
    add_column :users, :birthdate, :date, null: false
    add_column :users, :time_zone, :string, default: 'Central Time (US & Canada)', null: false
    add_index :users, :username
  end
end
