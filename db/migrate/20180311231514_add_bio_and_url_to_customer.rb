class AddBioAndUrlToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :bio, :text
    add_column :customers, :url, :string
    add_column :customers, :primary_manager_id, :integer
  end
end
