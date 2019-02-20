class Room < ApplicationRecord
  extend Utility

  validates_presence_of :no, :name, :list_price, :holiday_price, :hotday_price, :weekday_price
  validates_numericality_of :list_price, :holiday_price, :hotday_price, :weekday_price, only_integer: true

  # 輸出成csv格式 
  def self.to_csv(is_4_db=false, options = {})
    desired_columns = ["no", "name", "list_price", "holiday_price", "hotday_price", "weekday_price", "add_bed_fee"]
    export_columns = ["房號", "名稱", "定價", "假日價", "旺日價", "平日價", "加床費"]

    to_csv_string(desired_columns, export_columns)
  end

end
