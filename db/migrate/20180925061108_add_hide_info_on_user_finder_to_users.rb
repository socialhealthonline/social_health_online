class AddHideInfoOnUserFinderToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :hide_info_on_user_finder, :boolean, default: false
  end
end
