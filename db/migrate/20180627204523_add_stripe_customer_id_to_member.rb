class AddStripeCustomerIdToMember < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :stripe_customer_id, :string
  end
end
