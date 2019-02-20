class RoomCalendar < ApplicationRecord
  extend Utility

  ListPrice_Mode = 3
  Holiday_Mode = 2
  Hotday_Mode  = 1
  Weekday_Mode = 0

  Occupaied_Price = -1

  def room_summary(room_no)
    room_hash = get_room_hash(room_no)
    summary = room_hash["summary"].presence
  end

  def get_room_hash(room_no)
    room_hash = {}
    room_json = ""
    case room_no
      when "301"
        room_json = r301
      when "302"
        room_json = r302
      when "303"
        room_json = r303
      when "305"
        room_json = r305
      when "306"
        room_json = r306
      when "101"
        room_json = r101
      when "102"
        room_json = r102
      when "103"
        room_json = r103
      when "105"
        room_json = r105
      when "201"
        room_json = r201
      when "202"
        room_json = r202
      when "203"
        room_json = r203
      when "205"
        room_json = r205
      else
        room_json = ""
    end

    if room_json.present?
      # json to hash
      room_hash = JSON.parse room_json.gsub!('=>', ':')
    end
    room_hash
  end


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

  # 輸出成csv格式 
  def self.to_csv(is_4_db=false, options = {})
    desired_columns = ["day", "day_mode", "day_info"]
    export_columns = ["日期", "日期型態", "備註"]

    to_csv_string(desired_columns, export_columns)
  end

end
