FactoryBot.define do
  factory :post do
    title "This is a title"
    body "This is the body"

    trait :invalid_title do
      title ""
    end

    trait :invalid_body do
      body ""
    end
  end
end