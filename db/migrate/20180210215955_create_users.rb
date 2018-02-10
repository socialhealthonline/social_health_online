class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.boolean :enabled, default: true, null: false
      t.boolean :admin, default: false, null: false
      t.string :auth_token
      t.string :password_digest, null: false
      t.string :password_reset_token
      t.datetime :password_reset_sent_at
      t.datetime :last_sign_in_at
      t.timestamps
    end
    add_index :users, :enabled
    add_index :users, :auth_token
    add_index :users, :email
    add_index :users, :password_reset_token
  end
end
