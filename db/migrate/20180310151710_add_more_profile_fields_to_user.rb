class AddMoreProfileFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :relationship_status, :string
    add_column :users, :education_level, :string
    add_column :users, :occupation, :text
    add_column :users, :languages, :text
    add_column :users, :hobbies, :text
    add_column :users, :pet_peeves, :text
    add_column :users, :bio, :text
  end
end
