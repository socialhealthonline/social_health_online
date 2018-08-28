class CreateTargets < ActiveRecord::Migration[5.2]
  def change
    create_table :targets do |t|
      t.string :month
      t.string :weekone
      t.string :weektwo
      t.string :weekthree
      t.string :weekfour
      t.string :weekfive
      t.string :targetone
      t.string :targettwo
      t.string :targetthree
      t.string :targetfour
      t.string :targetfive

      t.timestamps
    end
  end
end
