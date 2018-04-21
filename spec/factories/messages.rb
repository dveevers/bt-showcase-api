FactoryBot.define do
  factory :message do
    channel { Faker::Lorem.word }
    created_at { Faker::Time.between(DateTime.now - 1, DateTime.now) }
    autor { Faker::Lorem.word }
    content {Faker::Lorem.word}
  end
end