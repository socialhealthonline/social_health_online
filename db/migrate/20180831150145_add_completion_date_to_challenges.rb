class AddCompletionDateToChallenges < ActiveRecord::Migration[5.2]
  def change
    add_column :challenges, :completion_date, :date
  end
end
