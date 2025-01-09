FactoryBot.define do
  factory :registry_host do
    source { Faker::Internet.url }
    destination { Faker::Internet.url }
    status { "active" }
    confidential { false }
    created_at { DateTime.now }
    updated_at { DateTime.now }

    trait :confidential do
      confidential { true }
    end
  end
end
