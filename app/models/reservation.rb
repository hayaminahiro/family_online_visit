class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :facility

  validates :reservation_date,  presence: true
  validates :started_at,        presence: true
  validates :reservation_user,  presence: true
  validates :reservation_email, presence: true
  validates :reservation_residents, presence: true

  TIME_1000 = "2000-01-01 10:00:00 +0900".freeze
  TIME_1030 = "2000-01-01 10:30:00 +0900".freeze
  TIME_1100 = "2000-01-01 11:00:00 +0900".freeze
  TIME_1130 = "2000-01-01 11:30:00 +0900".freeze
  TIME_1400 = "2000-01-01 14:00:00 +0900".freeze
  TIME_1430 = "2000-01-01 14:30:00 +0900".freeze
  TIME_1500 = "2000-01-01 15:00:00 +0900".freeze
  TIME_1530 = "2000-01-01 15:30:00 +0900".freeze
  TIME_1600 = "2000-01-01 16:00:00 +0900".freeze
  TIME_1630 = "2000-01-01 16:30:00 +0900".freeze

  scope :date, ->(date) { where(reservation_date: date)}
  scope :time_1000, ->(date) { where(reservation_date: date).where(started_at: TIME_1000) }
  scope :time_1030, ->(date) { where(reservation_date: date).where(started_at: TIME_1030) }
  scope :time_1100, ->(date) { where(reservation_date: date).where(started_at: TIME_1100) }
  scope :time_1130, ->(date) { where(reservation_date: date).where(started_at: TIME_1130) }
  scope :time_1400, ->(date) { where(reservation_date: date).where(started_at: TIME_1400) }
  scope :time_1430, ->(date) { where(reservation_date: date).where(started_at: TIME_1430) }
  scope :time_1500, ->(date) { where(reservation_date: date).where(started_at: TIME_1500) }
  scope :time_1530, ->(date) { where(reservation_date: date).where(started_at: TIME_1530) }
  scope :time_1600, ->(date) { where(reservation_date: date).where(started_at: TIME_1600) }
  scope :time_1630, ->(date) { where(reservation_date: date).where(started_at: TIME_1630) }

  scope :facility, ->(facility) { where(facility_id: facility)}
  scope :reservation_user, ->(name) { where(reservation_user: name)}
  scope :reservation_date, ->(date) { where(reservation_date: date)}
end
