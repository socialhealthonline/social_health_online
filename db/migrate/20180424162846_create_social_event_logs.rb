class CreateSocialEventLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :social_event_logs do |t|
      t.date :event_date, null: false
      t.string :state, null: false
      t.string :city, null: false
      t.string :event_type, null: false
      t.integer :source, default: 0, null: false
      t.string :category
      t.text :venue
      t.integer :rating, null: false

      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :social_event_logs, :user_id
    add_index :social_event_logs, :event_type
  end
end
