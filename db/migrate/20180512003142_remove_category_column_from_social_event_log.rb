class RemoveCategoryColumnFromSocialEventLog < ActiveRecord::Migration[5.2]
  def change
    remove_column :social_event_logs, :category, :string
  end
end
