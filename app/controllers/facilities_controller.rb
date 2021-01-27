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
    # 曜日が存在していた場合、該当する曜日の整数を代入
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
