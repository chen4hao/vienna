class Room < ApplicationRecord
  validates_presence_of :no, :name, :list_price, :holiday_price, :hotday_price, :weekday_price
  validates_numericality_of :list_price, :holiday_price, :hotday_price, :weekday_price, only_integer: true

  # 輸出成csv格式 
  def self.to_csv(is_4_db=false, options = {})
    desired_columns = ["no", "name", "list_price", "holiday_price", "hotday_price", "weekday_price", "add_bed_fee"]
    export_columns = ["房號", "名稱", "定價", "假日價", "旺日價", "平日價", "加床費"]

    export_columns = desired_columns if is_4_db
    CSV.generate(options) do |csv|
      csv << export_columns  #csv << column_names
      all.each do |object|
        csv << object.attributes.values_at(*desired_columns)
      end
    end
  end

end
