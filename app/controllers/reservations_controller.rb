class ReservationsController < ApplicationController
  before_action :set_facility_id
  before_action :set_reservation, only: %i[show destroy]

  def index
    @reservations = Reservation.all
  end

  def show; end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id
    @reservation.facility_id = params[:facility_id].to_i
    if @reservation.save
      redirect_to facility_reservations_url, notice: "
      #{l(@reservation.reservation_date.in_time_zone, format: :date)}/#{l(@reservation.started_at.in_time_zone, format: :time)}~で予約決定しました。"
    else
      render :new
    end
  end

  def destroy
    @reservation.destroy
    redirect_to facility_reservations_url, alert: "#{l(@reservation.reservation_date.in_time_zone, format: :date)}/#{l(@reservation.started_at, format: :time)}~の予約を取り消しました。"
  end

  private

    def reservation_params
      params.require(:reservation).permit(:calendar_day, :reservation_date, :started_at, :finished_at, :comment,
                                          :reservation_user, :reservation_email, reservation_residents: [])
    end

    def set_facility_id
      @facility = Facility.find(params[:facility_id])
    end

    def set_reservation
      @reservation = Reservation.find(params[:id])
    end
end
