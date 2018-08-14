class AddCityToBulletins < ActiveRecord::Migration[5.2]
  def change
    add_column :bulletins, :city, :string
  end
end
