class AddOrgTypeToAffiliates < ActiveRecord::Migration[5.2]
  def change
    add_column :affiliates, :org_type, :string
  end
end
