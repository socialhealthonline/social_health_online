FactoryBot.define do
  factory :customer do
    name 'ACME'
    address '123 Main St.'
    city 'Hometown'
    state 'AL'
    zip '35210'
    contact_name 'Tom Jones'
    contact_email 'tom@example.com'
    contact_phone '555-555-5555'
    service_capacity 1
  end
end
