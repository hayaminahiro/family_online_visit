FactoryBot.define do
  factory :calendar_setting do
    association :facility
    regular_holiday       { "日曜日" }
    cancellation_time     { "10:00 ~ 10:30" }
  end
end
