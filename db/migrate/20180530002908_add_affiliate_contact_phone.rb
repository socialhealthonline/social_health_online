class AddAffiliateContactPhone < ActiveRecord::Migration[5.2]
  def change
    add_column :affiliates, :contact_phone, :string
  end
end
