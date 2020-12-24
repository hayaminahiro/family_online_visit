FactoryBot.define do
  factory :reservation do
    association :user
    association :facility
    sequence(:reservation_date, Date.today)
    sequence(:started_at, DateTime.now)
    sequence(:finished_at, DateTime.now)
    sequence(:comment)            { |n| "comment#{n}" }
    sequence(:reservation_user)   { |n| "reservation_user#{n}" }
    sequence(:reservation_email)  { |n| "reservation_email#{n}" }
    reservation_residents         {"[\"resident1\", \"resident2\", \"resident3\"]"}
  end
end
