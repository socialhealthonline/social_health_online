FactoryBot.define do
  factory :event do
    title 'Event Title'
    start_at Time.current
    event_type EVENT_TYPES.sample
  end
end
