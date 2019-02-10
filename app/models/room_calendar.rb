class RoomCalendar < ApplicationRecord
  ListPrice_Mode = 3
  Holiday_Mode = 2
  Hotday_Mode  = 1
  Weekday_Mode = 0

  Occupaied_Price = -1

  def get_price(room_no)
    price = 0
    case day_mode
    when ListPrice_Mode
      price = Room.find_by_no(room_no).list_price
    when Holiday_Mode
      price = Room.find_by_no(room_no).holiday_price
    when Hotday_Mode
      price = Room.find_by_no(room_no).hotday_price
    else
      price = Room.find_by_no(room_no).weekday_price
    end
    price
  end

  def is_occupaied?(room_no)
    is_occupaied = false
    case room_no
    when "301"
      is_occupaied = r301.present?
    when "302"
      is_occupaied = r302.present?
    when "303"
      is_occupaied = r303.present?
    when "305"
      is_occupaied = r305.present?
    when "306"
      is_occupaied = r306.present?
    when "101"
      is_occupaied = r101.present?
    when "102"
      is_occupaied = r102.present?
    when "103"
      is_occupaied = r103.present?
    when "105"
      is_occupaied = r105.present?
    when "201"
      is_occupaied = r201.present?
    when "202"
      is_occupaied = r202.present?
    when "203"
      is_occupaied = r203.present?
    when "205"
      is_occupaied = r205.present?
    else
      is_occupaied = false
    end
    is_occupaied

  end

  def to_dealday
    self.update_columns(day_mode: ListPrice_Mode)
  end

  def to_holiday
    self.update_columns(day_mode: Holiday_Mode)
  end

  def to_hotday
    self.update_columns(day_mode: Hotday_Mode)
  end

  def to_weekday
    self.update_columns(day_mode: Weekday_Mode)
  end

end
