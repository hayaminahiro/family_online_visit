class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :facility

  validates :reservation_residents, presence: true

  TIME_1000 = "2000-01-01 10:00:00 +0900"
  TIME_1100 = "2000-01-01 11:00:00 +0900"
  TIME_1400 = "2000-01-01 14:00:00 +0900"
  TIME_1500 = "2000-01-01 15:00:00 +0900"
end
