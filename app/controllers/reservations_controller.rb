class ReservationsController < ApplicationController
  before_action :set_facility_id
  before_action :set_reservation, only: %i[show destroy]

  def index
    @reservations = Reservation.all.order(reservation_date: "ASC")
    @user = User.find(params[:user]) if params[:user].present?
  end

  def show; end

  def reservation_time
    @reservations = Reservation.all
    @title_date = params[:title_date]
    @date = params[:date]
    @user = User.find(params[:user]) if params[:user].present?
  end

  def index_week
    @reservations = Reservation.all.order(reservation_date: "ASC")
    @user = User.find(params[:user]) if params[:user].present?
  end

  def new
    @reservation = Reservation.new
    # 管理者側からの予約
    if params[:user].present?
      user = User.find(params[:user])
      @reservation.user_id = user.id
      @user = User.find(@reservation.user_id)
      @reservation.reservation_user = user.name
      @reservation.reservation_email = user.email
    end
    @reservation.reservation_date = params[:date]
    @reservation.started_at = params[:time]
  end

  def create
    @reservation = Reservation.new(reservation_params)
    # 管理者側からご家族の特定
    @user = User.find(@reservation.user_id) if @reservation.user_id
    # ご家族側から予約するご家族IDの特定
    @reservation.user_id = current_user.id if current_user.present?
    # 管理者・ご家族共通/施設ID取得
    @reservation.facility_id = params[:facility_id].to_i
    if @reservation.save
      redirect_to facility_reservation_url(@facility, @reservation, user: @reservation.user_id), notice: "
      #{l(@reservation.reservation_date.in_time_zone, format: :date)}/#{l(@reservation.started_at.in_time_zone, format: :time)}~で予約決定しました。"
    else
      render :new
    end
  end

  def destroy
    @reservation.destroy
    redirect_to facility_reservations_url(user: @reservation.user_id), alert: "#{l(@reservation.reservation_date.in_time_zone, format: :date)}/#{l(@reservation.started_at, format: :time)}~の予約を取り消しました。"
  end

  private

    def reservation_params
      params.require(:reservation).permit(:calendar_day, :reservation_date, :started_at, :finished_at, :comment, :reservation_user, :reservation_email, :user_id, :facility_id, reservation_residents: [])
    end

    def set_facility_id
      @facility = Facility.find(params[:facility_id])
    end

    def set_reservation
      @reservation = Reservation.find(params[:id])
    end
end
