class FacilitiesController < ApplicationController
  before_action :set_facility, only: %i[destroy show facility_home]
  before_action :set_facility_id, only: :home
  # ログインしてなければ閲覧不可
  before_action :authenticate_facility!, except: :home
  before_action :authenticate_user!, only: :home
  before_action :index_access_limits, only: :index

  def index
    @facilities = Facility.search(params[:search]).paginate(page: params[:page], per_page: 30)
  end

  def show; end

  # 各施設のホーム画面
  def home
    @request = current_user.request_residents.order(created_at: :desc).where(facility_id: @facility.id).first
  end

  # 施設ルートのhome画面
  def facility_home
    @info_top = Information.find_by(status: "head")
    @request_residents = RequestResident.where(req_approval: "request").where(facility_id: current_facility)
    # カレンダー設定と予約
    @calendar_settings = CalendarSetting.all.facility(current_facility)
    @reservations = Reservation.all.sorted
    @reservations_facility_max = @reservations.facility(current_facility)
    @reservations_facility_day_max = @reservations_facility_max.reservation_user(@user.try(:name))
    @reservations_user_max = @reservations.facility(@facility)
    @reservations_user_day_max = @reservations_user_max.reservation_user(current_user.try(:name))
    @set_id = @calendar_settings.find_by(facility_id: current_facility.id).try(:id)
    if @calendar_settings.find_by(facility_id: current_facility.id).try(:present?)
      @sunday = 0 if @calendar_settings.find_by(facility_id: current_facility.id).regular_holiday.include?("日曜日")
      @monday = 1 if @calendar_settings.find_by(facility_id: current_facility.id).regular_holiday.include?("月曜日")
      @tuesday = 2 if @calendar_settings.find_by(facility_id: current_facility.id).regular_holiday.include?("火曜日")
      @wednesday = 3 if @calendar_settings.find_by(facility_id: current_facility.id).regular_holiday.include?("水曜日")
      @thursday = 4 if @calendar_settings.find_by(facility_id: current_facility.id).regular_holiday.include?("木曜日")
      @friday = 5 if @calendar_settings.find_by(facility_id: current_facility.id).regular_holiday.include?("金曜日")
      @saturday = 6 if @calendar_settings.find_by(facility_id: current_facility.id).regular_holiday.include?("土曜日")
    end
  end

  def destroy
    @facility.destroy
    redirect_to facilities_url, alert: "「#{@facility.facility_name}」の施設情報を削除しました。"
  end

  private

    def index_access_limits
      redirect_to :root and return until current_facility.admin?
    end

    def set_facility
      @facility = Facility.find(params[:id])
    end

    def set_facility_id
      @facility = Facility.find(params[:facility_id])
    end
end
