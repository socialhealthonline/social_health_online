class AddPhoneExtensionToUserProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :phone_extension, :string
  end
end
