class AddAddressToBulletins < ActiveRecord::Migration[5.2]
  def change
    add_column :bulletins, :address, :string
  end
end
