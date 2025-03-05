FactoryBot.define do
  factory :idea do
    description {Faker::Lorem.unique.word}
    nich
  end
end
