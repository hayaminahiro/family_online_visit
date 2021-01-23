class CalendarSetting < ApplicationRecord
  belongs_to :facility

  DayOfTheWeek =["月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日", "日曜日"].freeze
  ReservationTimes =["10:00 ~ 10:30", "10:30 ~ 11:00", "11:00 ~ 11:30", "11:30 ~ 12:00", "14:00 ~ 14:30", "14:30 ~ 15:00", "15:00 ~ 15:30", "15:30 ~ 16:00", "16:00 ~ 16:30", "16:30 ~ 17:00"].freeze

  scope :facility, ->(facility) { where(facility_id: facility) }
end
