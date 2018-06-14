FactoryBot.define do
  factory :member do
    sequence(:name) { |n| "Member#{n}" }
    address '123 Main St.'
    city 'Hometown'
    state 'AL'
    zip '35210'
    contact_name 'Tom Jones'
    contact_email 'tom@example.com'
    contact_phone '555-555-5555'
    phone '5555555555'
    service_capacity 100
  end
end
