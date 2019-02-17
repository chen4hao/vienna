class Service < ApplicationRecord
  validates_presence_of :name, :list_price
  validates_numericality_of :list_price, only_integer: true

  # 輸出成csv格式 
  def self.to_csv(is_4_db=false, options = {})
    desired_columns = ["name", "list_price", "category"]
    export_columns = ["名稱", "定價", "類別"]

    export_columns = desired_columns if is_4_db
    CSV.generate(options) do |csv|
      csv << export_columns  #csv << column_names
      all.each do |object|
        csv << object.attributes.values_at(*desired_columns)
      end
    end
  end

end
