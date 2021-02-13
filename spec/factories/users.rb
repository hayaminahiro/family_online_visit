FactoryBot.define do
  factory :user do
    sequence(:name)       { |n| "sample#{n}" }
    sequence(:email)      { |n| "TEST#{n}@example.com" }
    phone                 { "08012345678" }
    password              { "password" }
    password_confirmation { "password" }
    postal_code           { "1234567" }
    prefecture_name       { "Tokyo" }
    address_city          { "tyuuou" }
    address_street        { "nihonbashi" }
  end
end
