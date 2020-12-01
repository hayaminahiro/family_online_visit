FactoryBot.define do
  factory :request_resident do
    association :user
    sequence(:req_name)  { |n| "sample#{n}" }
    req_phone            { "08012345678" }
    req_address          { "Tokyo" }
  end
end
