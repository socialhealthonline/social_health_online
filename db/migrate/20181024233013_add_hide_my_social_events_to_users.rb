class AddHideMySocialEventsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :hide_my_social_events, :boolean, default: false
  end
end
