FactoryBot.define do
  factory :nich do
    name { Faker::Lorem.unique.word }
    project
  end
end
