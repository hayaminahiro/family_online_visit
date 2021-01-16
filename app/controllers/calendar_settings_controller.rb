class CalendarSettingsController < ApplicationController
  def index
    @facility = Facility.find(current_facility.id)
    @reservations = Reservation.all.sorted
    @reservations_facility_max = @reservations.facility(current_facility)
    @reservations_facility_day_max = @reservations_facility_max.reservation_user(@user.name) if @user.present?
    @reservations_user_max = @reservations.facility(@facility)
    @reservations_user_day_max = @reservations_user_max.reservation_user(current_user.name) if current_user.present?
  end
end
