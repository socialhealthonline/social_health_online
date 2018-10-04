class AddDeletedAtToMailboxerConversations < ActiveRecord::Migration[5.2]
  def change
    add_column :mailboxer_conversations, :deleted_at, :datetime
    add_index :mailboxer_conversations, :deleted_at
  end
end
