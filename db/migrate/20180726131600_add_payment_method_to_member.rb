class AddPaymentMethodToMember < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :payment_method, :integer
  end
end
