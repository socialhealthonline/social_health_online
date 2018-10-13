class AddFavoriteIdToFavorites < ActiveRecord::Migration[5.2]
  def change
    add_column :favorites, :Favorite_Id, :integer
  end
end
