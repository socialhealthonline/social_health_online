class AddMemberIdToChallenges < ActiveRecord::Migration[5.2]
  def change
    add_column :challenges, :member_id, :bigint
  end
end
