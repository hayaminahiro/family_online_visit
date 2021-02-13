FactoryBot.define do
  factory :request_resident do
    association :user
    sequence(:req_name) { |n| "sample#{n}" }
  end
end
