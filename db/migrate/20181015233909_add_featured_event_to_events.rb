class AddFeaturedEventToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :featured_event, :boolean, default: false
  end
end
