class ReservationsController < ApplicationController
  # ログインしてなければ閲覧不可
  # before_action :authenticate_user!, only: %i[top_notice show]
  # before_action :authenticate_facility!, only: %i[index create new update destroy]
  # before_action :set_information, only: %i[show edit update destroy]

  def index
    @reservations = Reservation.all
    @facility = Facility.find(params[:facility_id])
    # raise
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id
    @reservation.facility_id = params[:facility_id].to_i
    if @reservation.save
      # raise
      redirect_to facility_reservations_url, notice: "#{@reservation.reservation_time}の#{@reservation.started_at}で予約決定しました。"
    else
      render :new
    end
  end

  private

    def reservation_params
      params.require(:reservation).permit(:calendar_day, :reservation_time, :started_at, :finished_at, :comment)
    end

    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

end
