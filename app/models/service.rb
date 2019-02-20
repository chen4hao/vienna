class Service < ApplicationRecord
  extend Utility

  validates_presence_of :name, :list_price
  validates_numericality_of :list_price, only_integer: true

  # 輸出成csv格式 
  def self.to_csv(is_4_db=false, options = {})
    desired_columns = ["name", "list_price", "category"]
    export_columns = ["名稱", "定價", "類別"]

    to_csv_string(desired_columns, export_columns)
  end

end
