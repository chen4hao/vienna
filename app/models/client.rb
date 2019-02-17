class Client < ApplicationRecord
  validates_presence_of :name

  has_many :orders, dependent: :destroy

  # accepts_nested_attributes_for :orders

  # 輸出成csv格式 
  def self.to_csv(is_4_db=false, options = {})
    desired_columns = ["name", "sex", "mobile", "country", "id_no", "birthday", "job", "tel", "address", "email", "reminder", "note"]
    export_columns = ["姓名", "性別", "手機", "國別", "身分證/護照", "生日", "職業", "電話", "地址", "email", "提醒(外)", "備註(內)"]

    export_columns = desired_columns if is_4_db
    CSV.generate(options) do |csv|
      csv << export_columns  #csv << column_names
      all.each do |object|
        csv << object.attributes.values_at(*desired_columns)
      end
    end
  end
end


