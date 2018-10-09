class AddHideSuggestAnnouncementsToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :hide_suggest_announcements, :boolean, default: false
  end
end
