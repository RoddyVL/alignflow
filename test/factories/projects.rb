FactoryBot.define do
  factory :project do
    name { Faker::Lorem.unique.word }
    user
  end
end
