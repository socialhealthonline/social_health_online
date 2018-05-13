class CreateSocialFitnessLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :social_fitness_logs do |t|
      t.integer :individuals, null: false
      t.integer :groups, null: false
      t.integer :family, null: false
      t.integer :friends, null: false
      t.integer :colleagues, null: false
      t.integer :significant_other, null: false
      t.integer :local_community, null: false
      t.integer :overall, null: false

      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :social_fitness_logs, :user_id
  end
end
