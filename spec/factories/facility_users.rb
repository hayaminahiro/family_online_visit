FactoryBot.define do
  factory :facility_user do
    association :user
    association :facility
  end
end
