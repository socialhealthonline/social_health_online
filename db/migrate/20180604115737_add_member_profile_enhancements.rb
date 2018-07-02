class AddMemberProfileEnhancements < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :phone, :string
    add_column :members, :contact_phone_extension, :string
  end
end
