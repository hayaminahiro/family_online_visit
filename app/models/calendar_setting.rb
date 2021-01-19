class CalendarSetting < ApplicationRecord
  belongs_to :facility

  # enum regular_holiday: {
  #     日曜日: 0, 月曜日: 1, 火曜日: 2, 水曜日: 3, 木曜日: 4, 金曜日: 5, 土曜日: 6
  # }, _suffix: true
  scope :facility, ->(facility) { where(facility_id: facility) }
end
