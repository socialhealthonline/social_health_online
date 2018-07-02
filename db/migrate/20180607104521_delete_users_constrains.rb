class DeleteUsersConstrains < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :name, :string, null: true
    change_column :users, :address, :string, null: true
    change_column :users, :city, :string, null: true
    change_column :users, :state, :string, null: true
    change_column :users, :zip, :string, null: true
    change_column :users, :phone, :string, null: true
    change_column :users, :gender, :string, null: true
    change_column :users, :ethnicity, :string, null: true
    change_column :users, :birthdate, :date, null: true
  end
end
