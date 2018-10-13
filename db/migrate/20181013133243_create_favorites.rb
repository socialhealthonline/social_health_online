class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.string :slug
      t.string :url
      t.string :name
      t.bigint :member_id
      t.string :title
      t.bigint :user_id

      t.timestamps
    end
  end
end
