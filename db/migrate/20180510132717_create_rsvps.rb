class CreateRsvps < ActiveRecord::Migration[5.2]
  def change
    create_table :rsvps do |t|
      t.string :rsvp_status
      t.belongs_to :event
      t.belongs_to :user
      t.timestamps
    end
  end
end
