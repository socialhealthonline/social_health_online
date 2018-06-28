class AddEventCategoryToSocialEventLog < ActiveRecord::Migration[5.2]
  def change
    add_column :social_event_logs, :event_category, :string
  end
end
