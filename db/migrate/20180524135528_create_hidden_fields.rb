class CreateHiddenFields < ActiveRecord::Migration[5.2]
  def change
    create_table :hidden_fields do |t|
      t.belongs_to :user
      t.jsonb :settings, null: false, default: { name: true,
                                                 email: true,
                                                 phone: true,
                                                 address: true,
                                                 city: true,
                                                 state: true,
                                                 zip: true,
                                                 time_zone: true,
                                                 birthdate: true,
                                                 gender: true,
                                                 ethnicity: true,
                                                 matchmaker: true }
      t.timestamps
    end
  end
end
