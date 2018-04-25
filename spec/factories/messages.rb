FactoryBot.define do
  factory :message do
    channel { Faker::Lorem.word }
    created_at { Faker::Time.between( DateTime.now - 2, DateTime.now - 1 ) }
    created_by { Faker::Lorem.word }
    content {Faker::Lorem.word}
    direction { Faker::Lorem.word}
    keyword { Faker::Lorem.word}
    extra { Faker::Lorem.word}
  end
end