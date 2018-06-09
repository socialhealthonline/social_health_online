FactoryBot.define do
  factory :affiliate do
    name "Affiliate LLC"
    address "123 Main St."
    city "Hometown"
    state "AL"
    zip "35210"
    support_type { Affiliate::SUPPORT_TYPES.sample }
    contact_name 'Joel jones'
    contact_phone '127618872661'
    contact_email 'contact@example.com'
    date_added Date.today
  end
end
