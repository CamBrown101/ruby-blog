FactoryBot.define do
  factory :post do
    title { Faker::Book.title }
    body { Faker::Quote.most_interesting_man_in_the_world}
  end
end