class CalendarSettingsController < ApplicationController
  before_action :set_facility_id
  before_action :set_calendar_setting, only: %i[edit update destroy]
  before_action :calendar_settings_all, only: %i[index new edit]

  def index
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

  def new
    @calendar_setting = @facility.calendar_setting.new
  end

  def create
    @calendar_setting = @facility.calendar_setting.new(setting_params)
    if @calendar_setting.save
      redirect_to calendar_settings_url, notice: "予約設定を変更しました。"
    else
      render :new
    end
  end

  def edit; end

  def update
    if @calendar_setting.update(setting_params)
      redirect_to calendar_settings_url, notice: "予約設定を変更しました。"
    else
      render :edit
    end
  end

  def destroy
    @calendar_setting.delete
    redirect_to calendar_settings_url, alert: "予約設定をデフォルトに戻しました。"
  end

  private
    def set_facility_id
      @facility = Facility.find(current_facility.id)
    end

    def set_calendar_setting
      @calendar_setting = @facility.calendar_setting.find(params[:id])
    end

    def calendar_settings_all
      @calendar_settings = CalendarSetting.all.facility(current_facility)
    end

    def setting_params
      params.require(:calendar_setting).permit(:cancellation_date, :cancellation_time, regular_holiday: [], cancellation_time: [])
    end

end
