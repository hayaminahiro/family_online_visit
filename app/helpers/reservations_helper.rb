module ReservationsHelper
  def calendar_reservation
    Reservation.where.not(calendar_day: nil)
  end
end
