FactoryBot.define do
  factory :post do
    title { Faker::Book.title }
    body { Faker::Quote}
  end
end