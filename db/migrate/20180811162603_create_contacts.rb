class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :display_name
      t.string :city
      t.string :state
      t.text :notes

      t.timestamps
    end
  end
end
