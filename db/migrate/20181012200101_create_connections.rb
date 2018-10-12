class CreateConnections < ActiveRecord::Migration[5.2]
  def change
    create_table :connections do |t|
      t.string :name
      t.string :url
      t.string :notes

      t.timestamps
    end
  end
end
