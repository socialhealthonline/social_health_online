class CreateChallenges < ActiveRecord::Migration[5.2]
  def change
    create_table :challenges do |t|
      t.string :name
      t.date :challenge_start_date
      t.date :challenge_end_date
      t.string :description
      t.string :url
      t.string :city
      t.string :state
      t.string :zip
      t.string :address
      t.string :location
      t.string :prize
      t.string :verification_code
      t.string :email
      t.integer :user_id
      t.string :display_name
      t.boolean :hide_challenges, default: false
      t.string :challenge_type
      t.string :challenge_level

      t.timestamps
    end
  end
end
