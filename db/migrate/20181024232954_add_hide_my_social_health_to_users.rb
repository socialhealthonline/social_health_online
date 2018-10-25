class AddHideMySocialHealthToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :hide_my_social_health, :boolean, default: false
  end
end
