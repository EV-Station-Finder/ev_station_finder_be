FactoryBot.define do
  factory :user_station do
    user_id { Faker::Number.number(digits: 1) }
    station_id { Faker::Number.number(digits: 1) }
  end
end
