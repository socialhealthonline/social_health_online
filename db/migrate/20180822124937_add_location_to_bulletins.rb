class AddLocationToBulletins < ActiveRecord::Migration[5.2]
  def change
    add_column :bulletins, :location, :string
  end
end
