class CreateEventTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :event_types do |t|
      t.string :name, null: false
      t.references :social_event_log, foreign_key: true

      t.timestamps
    end
  end
end
