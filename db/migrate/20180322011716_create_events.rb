class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.integer :member_id, null: false
      t.string :title, null: false
      t.datetime :start_at, null: false
      t.string 'time_zone', default: 'Central Time (US & Canada)', null: false
      t.string :event_type, null: false
      t.string :state
      t.string :city
      t.string :location
      t.string :url
      t.text :details
      t.boolean :private, default: false, null: false
      t.integer :rsvp_limit
      t.timestamps
    end
    add_index :events, :member_id
    add_index :events, :start_at
    add_index :events, :event_type
    add_index :events, :private
  end
end
