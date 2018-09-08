class CreateRewards < ActiveRecord::Migration[5.2]
  def change
    create_table :rewards do |t|
      t.string :source_type
      t.string :month
      t.string :periodone
      t.string :periodtwo
      t.string :periodthree
      t.string :periodfour
      t.string :periodfive
      t.text :winnersone
      t.text :winnerstwo
      t.text :winnersthree
      t.text :winnersfour
      t.text :winnersfive

      t.timestamps
    end
  end
end
