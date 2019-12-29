FactoryBot.define do
  factory :user do
    first_name { Faker::Name.name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { 'foobar' }
  end
end
