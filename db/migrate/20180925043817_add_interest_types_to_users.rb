class AddInterestTypesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :interest_types, :string
  end
end
