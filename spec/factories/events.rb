FactoryBot.define do
  factory :event do
    title 'Event Title'
    address '123 Main St.'
    city 'Hometown'
    zip '35210'
    location 'Somewhere'
    start_at Time.current
    event_type EVENT_TYPES.sample
  end
end
