FactoryBot.define do
  factory :user do
    name 'Tom Jones'
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'Password007'
    password_confirmation 'Password007'

    trait :admin do
      admin true
    end

    trait :disabled do
      enabled false
    end
  end

end
