class AddHideAnnouncementsToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :hide_announcements, :boolean, default: false
  end
end
