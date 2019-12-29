FactoryBot.define do
  factory :checkin do
    user_id { Faker::Number.between(1,10) }
    registrar_id { Faker::Number.between(1,10) }
    time { 1.minute.ago }
  end
end
