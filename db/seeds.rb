# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 新增管理者及測試者帳號
if User.count < 1
  User.create(email:"admin@vienna.com.tw", name:"admin", title:"管理者", password:"12345678", password_confirmation:"12345678", is_admin: true)
  User.create(email:"test@vienna.com.tw", name:"test", title:"員工", password:"123456", password_confirmation:"123456", is_admin: false)
end

# 新增服務資料
if Service.count < 1
  Service.create(name: "火鍋", list_price: 150, category: "晚餐")
  Service.create(name: "烤肉", list_price: 200, category: "晚餐")
  Service.create(name: "東勢─民宿", list_price: 2500, category: "接送導覽")
  Service.create(name: "飛牛牧場─民宿", list_price: 2800, category: "接送導覽")
  Service.create(name: "霧社─民宿", list_price: 200, category: "接送導覽")
  Service.create(name: "民宿─台中(8小時)", list_price: 3500, category: "接送導覽")
  Service.create(name: "民宿─關西六福莊", list_price: 6000, category: "接送導覽")
  Service.create(name: "清境─日月潭(單趟)", list_price: 1500, category: "接送導覽")
  Service.create(name: "泰安溫泉─民宿", list_price: 4000, category: "接送導覽")
  Service.create(name: "台北─民宿(小車)", list_price: 5000, category: "接送導覽")
  Service.create(name: "高雄─民宿(小車)", list_price: 5000, category: "接送導覽")
  Service.create(name: "桃園機場─民宿", list_price: 4500, category: "接送導覽")
  Service.create(name: "合歡山高山導覽", list_price: 700, category: "接送導覽")
  Service.create(name: "奧萬大", list_price: 650, category: "接送導覽")
  Service.create(name: "廬山泡湯(不含湯券)", list_price: 350, category: "接送導覽")
  Service.create(name: "合歡山日出", list_price: 400, category: "接送導覽")
  Service.create(name: "合歡山日出＋Hiking", list_price: 750, category: "接送導覽")
  Service.create(name: "合歡山半日遊", list_price: 700, category: "接送導覽")
  Service.create(name: "一日包車", list_price: 3500, category: "接送導覽")
  Service.create(name: "台北─清境(平日來回)", list_price: 1200, category: "E-GO")
  Service.create(name: "台北─清境(假日來回)", list_price: 1300, category: "E-GO")
  Service.create(name: "台北─清境(平日)", list_price: 750, category: "E-GO")
  Service.create(name: "台北─清境(假日)", list_price: 850, category: "E-GO")
  Service.create(name: "中港轉運站─清境", list_price: 1360, category: "E-GO")
end

# 新增房間資料
if Room.count < 1
  Room.create(no: "301", name: "雅緻二人房", list_price: 6600, holiday_price: 4620, hotday_price: 3630, weekday_price: 2980, add_bed_fee: 0)
  Room.create(no: "302", name: "經典二人房", list_price: 6600, holiday_price: 4620, hotday_price: 3630, weekday_price: 2980, add_bed_fee: 1000)
  Room.create(no: "303", name: "經典二人房", list_price: 6600, holiday_price: 4620, hotday_price: 3630, weekday_price: 2980, add_bed_fee: 1000)
  Room.create(no: "305", name: "浪漫情人房", list_price: 7000, holiday_price: 4900, hotday_price: 3850, weekday_price: 3150, add_bed_fee: 1000)
  Room.create(no: "306", name: "溫馨二人房", list_price: 6000, holiday_price: 4200, hotday_price: 3300, weekday_price: 2700, add_bed_fee: 0)
  Room.create(no: "101", name: "迎曦四人房", list_price: 6700, holiday_price: 5380, hotday_price: 4350, weekday_price: 3500, add_bed_fee: 0)
  Room.create(no: "102", name: "迎曦二人房", list_price: 5400, holiday_price: 4380, hotday_price: 3320, weekday_price: 2800, add_bed_fee: 0)
  Room.create(no: "103", name: "迎曦四人房", list_price: 6700, holiday_price: 5380, hotday_price: 4350, weekday_price: 3500, add_bed_fee: 0)
  Room.create(no: "105", name: "豪華四人房", list_price: 8500, holiday_price: 6800, hotday_price: 5500, weekday_price: 4400, add_bed_fee: 0)
  Room.create(no: "201", name: "迎曦六人/家庭房", list_price: 8500, holiday_price: 6800, hotday_price: 5500, weekday_price: 4500, add_bed_fee: 0)
  Room.create(no: "202", name: "迎曦六人/家庭房", list_price: 8500, holiday_price: 6800, hotday_price: 5500, weekday_price: 4500, add_bed_fee: 0)
  Room.create(no: "203", name: "迎曦六人/家庭房", list_price: 8500, holiday_price: 6800, hotday_price: 5500, weekday_price: 4500, add_bed_fee: 0)
  Room.create(no: "205", name: "豪華八人迎曦家庭房", list_price: 12000, holiday_price: 9600, hotday_price: 7800, weekday_price: 6200, add_bed_fee: 0)
end
