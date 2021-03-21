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
    @menu_approval = Relative.eager_load(:resident).where(user_id: current_user).where(residents: { facility_id: @facility.id })
    @request = current_user.request_residents.order(created_at: :desc).where(facility_id: @facility.id).first
    @informations = Information.where(facility_id: @facility).order(id: "DESC").limit(15)
  end

  # 施設ルートのhome画面
  def facility_home
    @admin_informations = Information.where(status: "admin").order(id: "DESC").limit(15)
    @request_residents = RequestResident.includes(:user).where(req_approval: "request").where(facility_id: current_facility).order(id: :desc)
    # カレンダー設定と予約
    @calendar_setting = CalendarSetting.find_by(facility_id: current_facility.id)
    @reservations = Reservation.all.sorted
    # 曜日が存在していた場合、該当する曜日の整数を代入
    @week = []
    CalendarSetting::DAY_OF_THE_WEEK.each do |day|
      @week << @calendar_setting.regular_holiday.include?(day) if @calendar_setting.present? ? day : nil
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
