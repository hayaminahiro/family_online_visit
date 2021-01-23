class CalendarSettingsController < ApplicationController
  def index
    @facility = Facility.find(current_facility.id)
    @reservations = Reservation.all.sorted
    @reservations_facility_max = @reservations.facility(current_facility)
    @reservations_facility_day_max = @reservations_facility_max.reservation_user(@user.name) if @user.present?
    @reservations_user_max = @reservations.facility(@facility)
    @reservations_user_day_max = @reservations_user_max.reservation_user(current_user.name) if current_user.present?

    @calendar_settings = CalendarSetting.all
    @set_id = @calendar_settings.find_by(facility_id: current_facility.id).id if @calendar_settings.find_by(facility_id: current_facility.id).present?

    
    if current_facility.present?
      if @calendar_settings.find_by(facility_id: current_facility.id).present?
        @sunday = 0 if @calendar_settings.find_by(facility_id: current_facility.id).regular_holiday.include?("日曜日")
        @monday = 1 if @calendar_settings.find_by(facility_id: current_facility.id).regular_holiday.include?("月曜日")
        @tuesday = 2 if @calendar_settings.find_by(facility_id: current_facility.id).regular_holiday.include?("火曜日")
        @wednesday = 3 if @calendar_settings.find_by(facility_id: current_facility.id).regular_holiday.include?("水曜日")
        @thursday = 4 if @calendar_settings.find_by(facility_id: current_facility.id).regular_holiday.include?("木曜日")
        @friday = 5 if @calendar_settings.find_by(facility_id: current_facility.id).regular_holiday.include?("金曜日")
        @saturday = 6 if @calendar_settings.find_by(facility_id: current_facility.id).regular_holiday.include?("土曜日")
      end
    end
  end

  def new
    @facility = Facility.find(current_facility.id)
    @calendar_setting = @facility.calendar_setting.new
    @calendar_settings = CalendarSetting.all
  end

  def create
    @facility = Facility.find(current_facility.id)
    # @memory = @resident.memories.new(memories_params)
    # @calendar_setting.regular_holiday = setting_params[:regular_holiday].map(&:to_i)
    @calendar_setting = @facility.calendar_setting.new(setting_params)

    # raise
    #  ["0", "1"].map(&:to_i)
    if @calendar_setting.save!
      # raise
      redirect_to calendar_settings_url, notice: "success!"
    else
      render :new
    end
  end

  def edit
    @calendar_settings = CalendarSetting.all.where(facility_id: current_facility)
    @facility = Facility.find(current_facility.id)
    @calendar_setting = @facility.calendar_setting.find(params[:id])
  end

  def update
    @facility = Facility.find(current_facility.id)
    @calendar_setting = @facility.calendar_setting.find(params[:id])
    if @calendar_setting.update(setting_params)

      # raise
      redirect_to calendar_settings_url, notice: "success!"
    else
      render :edit
    end
  end

  def destroy
    @facility = Facility.find(current_facility.id)
    @calendar_setting = @facility.calendar_setting.find(params[:id])
    @calendar_setting.delete
    redirect_to calendar_settings_url, alert: "delete!"
  end


  private
    def setting_params
      params.require(:calendar_setting).permit(:cancellation_date, :cancellation_time, regular_holiday: [], cancellation_time: [])
    end
end
