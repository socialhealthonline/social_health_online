class ChangeEmailDefaultForUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :receive_email, :boolean, default: true
  end
end
