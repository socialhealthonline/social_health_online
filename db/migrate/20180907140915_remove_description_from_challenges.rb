class RemoveDescriptionFromChallenges < ActiveRecord::Migration[5.2]
  def change
    remove_column :challenges, :description, :string
  end
end
