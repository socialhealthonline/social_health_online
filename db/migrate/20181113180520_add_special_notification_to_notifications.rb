class AddSpecialNotificationToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :special_notification, :boolean, default: false
  end
end
