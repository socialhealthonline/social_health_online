class RenamePartnersToAffiliates < ActiveRecord::Migration[5.2]
  def change
    rename_table :partners, :affiliates
  end
end
