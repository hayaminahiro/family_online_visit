FactoryBot.define do
  factory :facility do
    sequence(:facility_name)  { |n| "sample#{n}" }
    sequence(:email)          { |n| "TEST#{n}@example.com" }
    password                  { "password" }
    password_confirmation     { "password" }
  end
end
