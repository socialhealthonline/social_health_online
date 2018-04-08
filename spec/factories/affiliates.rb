FactoryBot.define do
  factory :affiliate do
    name "Affiliate LLC"
    address "123 Main St."
    city "Hometown"
    state "AL"
    zip "35210"
    support_type { Affiliate::SUPPORT_TYPES.sample }
  end
end
