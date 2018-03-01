FactoryBot.define do
  factory :user do
    name 'Tom Jones'
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:username) { |n| "user#{n}" }
    password 'Password007'
    password_confirmation 'Password007'
    phone '555-555-5555'
    address '123 Main St.'
    city 'Hometown'
    state 'AL'
    zip '55555'
    birthdate (Date.today - 30.years)
    gender 'Male'
    ethnicity 'White'

    trait :admin do
      admin true
    end

    trait :disabled do
      enabled false
    end
  end

end
