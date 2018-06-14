class AddPhoneExtensionToHiddenFields < ActiveRecord::Migration[5.2]
  def change
    change_column_default :hidden_fields, :settings, default: { 'zip' => true, 'city' => true, 'name' => true, 'email' => true,
                                                    'phone' => true, 'state' => true, 'gender' => true, 'address' => true,
                                                    'birthdate' => true, 'ethnicity' => true, 'time_zone' => true,
                                                    'matchmaker' => true, 'phone_extension' => true }, null: false
  end
end
