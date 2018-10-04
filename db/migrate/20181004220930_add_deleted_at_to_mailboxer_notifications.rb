class AddDeletedAtToMailboxerNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :mailboxer_notifications, :deleted_at, :datetime
    add_index :mailboxer_notifications, :deleted_at
  end
end
