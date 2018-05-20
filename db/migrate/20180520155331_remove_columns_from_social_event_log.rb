class RemoveColumnsFromSocialEventLog < ActiveRecord::Migration[5.2]
  def change
    remove_column :social_event_logs, :event_type, :string
  end
end
