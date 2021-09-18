FactoryBot.define do
  factory :post do
    title "This is a title"
    body "This is the body"

    factory :post_with_invalid_title do
      title ""
    end

    factory :post_with_invalid_body do
      body ""
    end
  end
end