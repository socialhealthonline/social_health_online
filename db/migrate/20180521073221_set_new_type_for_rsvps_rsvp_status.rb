class SetNewTypeForRsvpsRsvpStatus < ActiveRecord::Migration[5.2]
  def change
    remove_column :rsvps, :rsvp_status, :string
    add_column :rsvps, :rsvp_status, :integer, null: false
  end
end
