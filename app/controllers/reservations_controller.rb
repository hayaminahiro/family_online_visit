class ReservationsController < ApplicationController
  before_action :set_facility_id
  before_action :change_facility, only: %i[index index_week]
  before_action :set_user, except: %i[show create destroy]
  before_action :set_reservation, only: %i[show destroy]
  before_action :set_reservations, only: %i[index index_week reservation_time]
  before_action :set_reservation_limit, only: %i[index index_week]
  before_action :calendar_settings, only: %i[index index_week reservation_time]

  def index; end

  def index_week; end

  def show; end

  def reservation_time
    @title_date = params[:title_date]
    @date = params[:date]
  end

  def new
    @reservation = Reservation.new
    @reservation.user_id = @user.id
    @reservation.reservation_user = @user.name
    @reservation.reservation_email = @user.email
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
      redirect_to facility_reservations_url(@facility, user: @reservation.user_id), notice: "
      #{l(@reservation.reservation_date.in_time_zone, format: :date)}/#{l(@reservation.started_at.in_time_zone, format: :time)}~で予約決定しました。"
    else
      render :new
    end
  end

  def destroy
    @reservation.destroy
    if params[:setting].present?
      redirect_to calendar_settings_url(user: @reservation.user_id), alert: "#{l(@reservation.reservation_date.in_time_zone, format: :date)}/#{l(@reservation.started_at, format: :time)}~の予約を取り消しました。"
    else
      redirect_to facility_reservations_url(user: @reservation.user_id), alert: "#{l(@reservation.reservation_date.in_time_zone, format: :date)}/#{l(@reservation.started_at, format: :time)}~の予約を取り消しました。"
    end
  end

  private

    def set_user
      @user = if params[:user].present?
                User.find(params[:user])
              else
                User.find(current_user.id)
              end
    end

    def set_facility_id
      @facility = Facility.find(params[:facility_id])
    end

    def change_facility
      @facility = current_facility if current_facility.present?
    end

    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    def set_reservations
      @reservations = Reservation.all.sorted
    end

    def set_reservation_limit
      @reservations_facility_max = @reservations.facility(current_facility)
      @reservations_facility_day_max = @reservations_facility_max.reservation_user(@user.name) if @user.present?
      @reservations_user_max = @reservations.facility(@facility)
      @reservations_user_day_max = @reservations_user_max.reservation_user(current_user.name) if current_user.present?
    end

    def calendar_settings
      @calendar_settings = CalendarSetting.all.facility(@facility)
      @week = []
      CalendarSetting::DAY_OF_THE_WEEK.each do |day|
        @week << @calendar_settings.find_by(facility_id: current_facility.id).regular_holiday.include?(day) ? day : nil
        num = -1
        while num < 6
          @week[num] = num + 1 if @week[num].present?
          num += 1
        end
      end
    end

    def reservation_params
      params.require(:reservation).permit(:calendar_day, :reservation_date, :started_at, :finished_at, :comment, :reservation_user, :reservation_email, :user_id, :facility_id, reservation_residents: [])
    end
end
