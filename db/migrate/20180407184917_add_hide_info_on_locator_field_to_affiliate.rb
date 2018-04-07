class AddHideInfoOnLocatorFieldToAffiliate < ActiveRecord::Migration[5.2]
  def change
    add_column :affiliates, :hide_info_on_locator, :boolean, default: false
  end
end
