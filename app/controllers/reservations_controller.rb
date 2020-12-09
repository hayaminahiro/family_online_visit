class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
  end

  def new
    # @reservations = Reservation.all
  end

end
