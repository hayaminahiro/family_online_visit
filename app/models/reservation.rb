class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :facility

  validates :reservation_residents, presence: true

  TIME_1000 = "2000-01-01 10:00:00 +0900".freeze
  TIME_1100 = "2000-01-01 11:00:00 +0900".freeze
  TIME_1400 = "2000-01-01 14:00:00 +0900".freeze
  TIME_1500 = "2000-01-01 15:00:00 +0900".freeze

  scope :time_1000, ->(date) { where(reservation_date: date).where(started_at: TIME_1000) }
  scope :time_1100, ->(date) { where(reservation_date: date).where(started_at: TIME_1100) }
  scope :time_1400, ->(date) { where(reservation_date: date).where(started_at: TIME_1400) }
  scope :time_1500, ->(date) { where(reservation_date: date).where(started_at: TIME_1500) }
end
