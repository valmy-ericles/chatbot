FactoryBot.define do
  factory :faq do
    question { Faker::Lorem.phrase }
    answer { Faker::Lorem.phrase }
  end
end
