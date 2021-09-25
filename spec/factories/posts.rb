FactoryBot.define do
  factory :post do
    title { Faker::Book.title }
    body { Faker::Quote}

    trait :invalid_title do
      title ""
    end

    trait :invalid_body do
      body ""
    end
  end
end