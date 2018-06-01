class AddAffiliateContactInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :affiliates, :contact_name, :string
    add_column :affiliates, :contact_phone_extension, :string
    add_column :affiliates, :contact_email, :string
    add_column :affiliates, :support_notes, :string
    add_column :affiliates, :date_added, :datetime
  end
end
