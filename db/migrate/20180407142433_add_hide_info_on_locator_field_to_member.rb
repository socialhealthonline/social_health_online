class AddHideInfoOnLocatorFieldToMember < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :hide_info_on_locator, :boolean, default: false
  end
end
