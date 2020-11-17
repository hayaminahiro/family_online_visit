FactoryBot.define do
  factory :memory do
    association :resident
    sequence(:title)     { |n| "title#{n}" }
    sequence(:message)   { |n| "message#{n}" }
    event_date           { "2020-12-01" }
    image0               { File.open("#{Rails.root}/public/signup-pic1.jpg") }
  end
end
