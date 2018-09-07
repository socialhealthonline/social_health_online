class AddDescriptionToChallenges < ActiveRecord::Migration[5.2]
  def change
    add_column :challenges, :description, :text
  end
end
