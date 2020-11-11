FactoryBot.define do
  factory :resident do
    association :facility
    sequence(:name)           { |n| "sample#{n}" }
    sequence(:charge_worker)  { |n| "charge_worker#{n}" }
  end
end
