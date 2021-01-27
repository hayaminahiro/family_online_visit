module CalendarSettingsHelper
  def calendar_setting(week, date)
    week[0] != date.wday && week[1] != date.wday && week[2] != date.wday && week[3] != date.wday && week[4] != date.wday && week[5] != date.wday && week[6] != date.wday
  end
end
