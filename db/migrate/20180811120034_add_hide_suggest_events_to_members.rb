class AddHideSuggestEventsToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :hide_suggest_events, :boolean, default: false
  end
end
