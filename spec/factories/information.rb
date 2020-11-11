FactoryBot.define do
  factory :information do
    association :facility
    sequence(:news)   { |n| "news#{n}" }
    sequence(:title)  { |n| "title#{n}" }
  end
end
