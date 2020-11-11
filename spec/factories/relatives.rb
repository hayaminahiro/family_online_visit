FactoryBot.define do
  factory :relative do
    association :user
    association :resident
  end
end
