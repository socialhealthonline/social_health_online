class AddWelcomeKitDateToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :welcome_kit_date, :datetime
  end
end
