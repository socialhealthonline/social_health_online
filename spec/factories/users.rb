FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Tom Jones #{n}"}
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:display_name) {|n| "Tom #{n}"}
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
    user_status :enabled
    first_login Date.today
    member

    trait :admin do
      admin true
    end

    trait :manager do
      manager true
    end

    trait :disabled do
      enabled false
    end

    trait :disabled_status do
      user_status 'disabled'
    end
  end

end
