module Utility
  # 輸出成csv格式 
  def to_csv_string(desired_columns, export_columns, is_4_db=false, options = {})
    export_columns = desired_columns if is_4_db
    csv_string = CSV.generate(options) do |csv|
      csv << export_columns  #csv << column_names
      all.each do |object|
        csv << object.attributes.values_at(*desired_columns)
      end
    end

    # 加入BOM，解決excel中文亂碼
    csv_string = "\xEF\xBB\xBF#{csv_string}"
    csv_string.force_encoding('big5')
  end

end
