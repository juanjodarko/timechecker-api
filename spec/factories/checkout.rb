FactoryBot.define do
  factory :checkout do
    user_id { Faker::Number.number(1) }
    registrar_id { Faker::Number.number(1) }
    time { 1.minute.ago }
  end
end
