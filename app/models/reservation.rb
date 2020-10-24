class Reservation < ApplicationRecord
  belongs_to :user

  def self.calendar_reservation
    Reservation.where.not(calendar_day: nil)
  end
end
