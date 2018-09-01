class AddZipToBulletins < ActiveRecord::Migration[5.2]
  def change
    add_column :bulletins, :zip, :string
  end
end
