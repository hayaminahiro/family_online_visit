class CalendarSettingsController < ApplicationController
  before_action :set_facility_id
  before_action :set_calendar_setting, only: %i[edit update destroy]
  before_action :calendar_setting, only: :edit

  def new
    @calendar_setting = @facility.calendar_setting.new
  end

  def create
    @calendar_setting = @facility.calendar_setting.new(setting_params)
    @calendar_setting.max_reservation = setting_params[:cancellation_time].length - 1
    if @calendar_setting.save
      redirect_to facility_home_facility_url(current_facility), notice: "予約設定を変更しました。"
    else
      render :new
    end
  end

  def edit; end

  def update
    @calendar_setting.max_reservation = setting_params[:cancellation_time].length - 1
    if @calendar_setting.update(setting_params)
      redirect_to facility_home_facility_url(current_facility), notice: "予約設定を変更しました。"
    else
      render :edit
    end
  end

  def destroy
    @calendar_setting.delete
    redirect_to facility_home_facility_url(current_facility), alert: "予約設定をデフォルトに戻しました。"
  end

  private

    def set_facility_id
      @facility = Facility.find(current_facility.id)
    end

    def set_calendar_setting
      @calendar_setting = @facility.calendar_setting.find(params[:id])
    end

    def calendar_setting
      @calendar_setting = CalendarSetting.facility(current_facility).first
    end

    def setting_params
      params.require(:calendar_setting).permit(:cancellation_date, :cancellation_time, :max_reservation, regular_holiday: [], cancellation_time: [])
    end
end
