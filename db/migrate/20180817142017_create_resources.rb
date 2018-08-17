class CreateResources < ActiveRecord::Migration[5.2]
  def change
    create_table :resources do |t|
      t.string :name
      t.string :city
      t.string :state
      t.string :url
      t.string :event_type

      t.timestamps
    end
  end
end
