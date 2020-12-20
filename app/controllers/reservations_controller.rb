class ReservationsController < ApplicationController
  # ログインしてなければ閲覧不可
  # before_action :authenticate_user!, only: %i[top_notice show]
  # before_action :authenticate_facility!, only: %i[index create new update destroy]
  # before_action :set_information, only: %i[show edit update destroy]

  def index
    @reservations = Reservation.all
    @facility = Facility.find(params[:facility_id])
  end

  def show
    @reservation = Reservation.find(params[:id])
    @facility = Facility.find(params[:facility_id])
    # raise
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id
    @reservation.facility_id = params[:facility_id].to_i
    if @reservation.save
      redirect_to facility_reservations_url, notice: "
      #{l(@reservation.reservation_date.to_time, format: :date)}/#{ l(@reservation.started_at.to_time, format: :time)}~で予約決定しました。"
    else
      render :new
    end
  end

  def destroy
    @facility = Facility.find(params[:facility_id])
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to facility_reservations_url, alert: "#{l(@reservation.reservation_date.to_time, format: :date)}/#{l(@reservation.started_at, format: :time)}~の予約を取り消しました。"
  end

  private

    def reservation_params
      params.require(:reservation).permit(:calendar_day, :reservation_date, :started_at, :finished_at, :comment,
                                          :reservation_user, :reservation_email, reservation_residents: [])
    end

    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

end
