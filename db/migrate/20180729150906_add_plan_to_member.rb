class AddPlanToMember < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :plan, :string
  end
end
