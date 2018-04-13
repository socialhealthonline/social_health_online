class AddSlugToMember < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :slug, :string
    add_index :members, :slug, unique: true
  end
end
