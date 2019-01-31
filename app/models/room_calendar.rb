class RoomCalendar < ApplicationRecord
  @@Day_Mode_Dealday = 3
  @@Day_Mode_Holiday = 2
  @@Day_Mode_Hotday  = 1
  @@Day_Mode_Weekday = 0

  def to_dealday
    self.update_columns(day_mode: Day_Mode_Dealday)
  end

  def to_holiday
    self.update_columns(day_mode: Day_Mode_Holiday)
  end

  def to_hotday
    self.update_columns(day_mode: Day_Mode_Hotday)
  end

  def to_weekday
    self.update_columns(day_mode: Day_Mode_Weekday)
  end

end
