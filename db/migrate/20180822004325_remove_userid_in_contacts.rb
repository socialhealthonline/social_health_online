class RemoveUseridInContacts < ActiveRecord::Migration[5.2]
  def change
    remove_column :contacts, :user_id
  end
end
