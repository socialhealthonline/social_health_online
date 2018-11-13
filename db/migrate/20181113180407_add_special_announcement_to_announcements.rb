class AddSpecialAnnouncementToAnnouncements < ActiveRecord::Migration[5.2]
  def change
    add_column :announcements, :special_announcement, :boolean, default: false
  end
end
