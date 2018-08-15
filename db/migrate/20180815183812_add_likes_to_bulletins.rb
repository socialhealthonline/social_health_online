class AddLikesToBulletins < ActiveRecord::Migration[5.2]
  def change
    add_column :bulletins, :likes, :integer
  end
end
