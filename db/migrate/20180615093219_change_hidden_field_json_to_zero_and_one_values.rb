class ChangeHiddenFieldJsonToZeroAndOneValues < ActiveRecord::Migration[5.2]
  def change
    change_column_default :hidden_fields, :settings, default: { 'zip' => '0', 'city' => '0', 'name' => '0', 'email' => '0',
                                                                'phone' => '0', 'state' => '0', 'gender' => '0', 'address' => '0',
                                                                'birthdate' => '0', 'ethnicity' => '0', 'time_zone' => '0',
                                                                'matchmaker' => '0', 'phone_extension' => '0' }, null: false
  end
end
