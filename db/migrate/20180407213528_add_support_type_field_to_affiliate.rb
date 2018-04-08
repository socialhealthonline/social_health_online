class AddSupportTypeFieldToAffiliate < ActiveRecord::Migration[5.2]
  def change
    add_column :affiliates, :support_type, :integer, default: 0, null: false
  end
end
