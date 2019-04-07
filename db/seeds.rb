# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def setup_accounts
  # 新增管理者及測試者帳號
  if User.count < 1
    User.create(email:"admin@vienna.com.tw", name:"admin", title:"管理者", password:"12345678", password_confirmation:"12345678", is_admin: true)
    User.create(email:"test@vienna.com.tw", name:"test", title:"員工", password:"123456", password_confirmation:"123456", is_admin: false)
  end
end

def setup_services
  # 新增服務資料
  if Service.count < 1
    Service.create(name: "火鍋", list_price: 150, category: "晚餐")
    Service.create(name: "烤肉", list_price: 200, category: "晚餐")
    # Service.create(name: "東勢─民宿", list_price: 2500, category: "接送導覽")
    # Service.create(name: "飛牛牧場─民宿", list_price: 2800, category: "接送導覽")
    # Service.create(name: "霧社─民宿", list_price: 200, category: "接送導覽")
    # Service.create(name: "民宿─台中(8小時)", list_price: 3500, category: "接送導覽")
    # Service.create(name: "民宿─關西六福莊", list_price: 6000, category: "接送導覽")
    # Service.create(name: "清境─日月潭(單趟)", list_price: 1500, category: "接送導覽")
    # Service.create(name: "泰安溫泉─民宿", list_price: 4000, category: "接送導覽")
    Service.create(name: "台北─民宿(小車)", list_price: 5000, category: "接送導覽")
    Service.create(name: "高雄─民宿(小車)", list_price: 5000, category: "接送導覽")
    Service.create(name: "桃園機場─民宿", list_price: 4500, category: "接送導覽")
    # Service.create(name: "合歡山高山導覽", list_price: 700, category: "接送導覽")
    # Service.create(name: "奧萬大", list_price: 650, category: "接送導覽")
    # Service.create(name: "廬山泡湯(不含湯券)", list_price: 350, category: "接送導覽")
    # Service.create(name: "合歡山日出", list_price: 400, category: "接送導覽")
    # Service.create(name: "合歡山日出＋Hiking", list_price: 750, category: "接送導覽")
    # Service.create(name: "合歡山半日遊", list_price: 700, category: "接送導覽")
    Service.create(name: "一日包車", list_price: 3500, category: "接送導覽")
    # Service.create(name: "台北─清境(平日來回)", list_price: 1200, category: "E-GO")
    # Service.create(name: "台北─清境(假日來回)", list_price: 1300, category: "E-GO")
    # Service.create(name: "台北─清境(平日)", list_price: 750, category: "E-GO")
    # Service.create(name: "台北─清境(假日)", list_price: 850, category: "E-GO")
    # Service.create(name: "中港轉運站─清境", list_price: 1360, category: "E-GO")
  end
end

def setup_rooms
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
end

def setup_calandar(start_year=Date.current.year, end_year=start_year)
  # 新增月曆(+設定週六為假日)
  start_year.upto(end_year) do |year|
    day = Date.new(year, 1, 1)
    1.upto(365) do
      if !RoomCalendar.find_by(day: day).present?
        if day.saturday?
          RoomCalendar.create(day: day, day_mode: 2, day_info: "週六假日")
        else
          RoomCalendar.create(day: day)
        end

        puts "日期:#{day.strftime("%Y-%m-%d %a")}(#{day.wday})"
      end
      day = day.tomorrow
    end
  end
end

def setup_2019calandar_special_days
  #元旦連假
  # RoomCalendar.where(day: "2019-01-01").update(day_mode: 3, day_info: "元旦連假")
  #春節連假
  RoomCalendar.where(day: "2019-02-02" .. "2019-02-09").update(day_mode: 3, day_info: "春節連假")
  #國定假日及連續假日
  RoomCalendar.where(day: "2019-02-28" .. "2019-03-02").update(day_mode: 2, day_info: "228連假")
  RoomCalendar.where(day: "2019-04-04" .. "2019-04-06").update(day_mode: 2, day_info: "清明節連假")
  RoomCalendar.where(day: "2019-05-01").update(day_mode: 2, day_info: "勞動節")
  RoomCalendar.where(day: "2019-06-07" .. "2019-06-08").update(day_mode: 2, day_info: "端午節連假")
  RoomCalendar.where(day: "2019-09-13" .. "2019-09-14").update(day_mode: 2, day_info: "中秋節連假")
  RoomCalendar.where(day: "2019-10-10" .. "2019-10-12").update(day_mode: 2, day_info: "雙十節連假")
  #寒暑假
  RoomCalendar.where(day: "2019-01-20" .. "2019-01-25").update(day_mode: 1, day_info: "寒假")
  RoomCalendar.where(day: "2019-01-27" .. "2019-02-01").update(day_mode: 1, day_info: "寒假")
  RoomCalendar.where(day: "2019-06-30" .. "2019-07-05").update(day_mode: 1, day_info: "暑假")
  RoomCalendar.where(day: "2019-07-07" .. "2019-07-12").update(day_mode: 1, day_info: "暑假")
  RoomCalendar.where(day: "2019-07-14" .. "2019-07-19").update(day_mode: 1, day_info: "暑假")
  RoomCalendar.where(day: "2019-07-21" .. "2019-07-26").update(day_mode: 1, day_info: "暑假")
  RoomCalendar.where(day: "2019-07-28" .. "2019-08-02").update(day_mode: 1, day_info: "暑假")
  RoomCalendar.where(day: "2019-08-04" .. "2019-08-09").update(day_mode: 1, day_info: "暑假")
  RoomCalendar.where(day: "2019-08-11" .. "2019-08-16").update(day_mode: 1, day_info: "暑假")
  RoomCalendar.where(day: "2019-08-18" .. "2019-08-23").update(day_mode: 1, day_info: "暑假")
  RoomCalendar.where(day: "2019-08-25" .. "2019-08-30").update(day_mode: 1, day_info: "暑假")
  #補上班
  RoomCalendar.where(day: "2019-01-19").update(day_mode: 0, day_info: "補上班")
  RoomCalendar.where(day: "2019-02-23").update(day_mode: 0, day_info: "補上班")
  RoomCalendar.where(day: "2019-10-05").update(day_mode: 0, day_info: "補上班")
end

# 設定客戶測試資料
def setup_clients
  if Client.count < 1
    Client.create(name:"廖維珍", sex:"男", mobile:"0935162682", country:"台灣", id_no:"L120807920", reminder:"", note:"")
    Client.create(name:"張佑嘉", sex:"女", mobile:"0989929875", country:"台灣", id_no:"H225850233", reminder:"", note:"")
    Client.create(name:"Chcin Hsia", sex:"男", mobile:"0917774695", country:"香港", id_no:"1646972679", reminder:"", note:"")
    Client.create(name:"Jaseph Chen", sex:"男", mobile:"65 96548875", country:"香港", id_no:"1645005537", reminder:"", note:"")
    Client.create(name:"譚意敏", sex:"女", mobile:"0928143215", country:"台灣", id_no:"K221597123", reminder:"", note:"")
    Client.create(name:"郭文鳳", sex:"女", mobile:"0929049528", country:"香港", id_no:"", reminder:"", note:"")
    Client.create(name: "t陳一", mobile: "1518282828" ,country:"日本")
    Client.create(name: "t林二", mobile: "2333388888" ,country:"韓國")
    Client.create(name: "t張三", mobile: "3999999484" ,country:"大陸")
    Client.create(name: "t李四", mobile: "1383838838" ,country:"日本")
  end
end

def setup_orders
  # if Order.count < 1
    d0=Date.new(2019,2,17)
    d1=Date.new(2019,2,1)
    d2=Date.new(2019,2,16)
    d3=Date.new(2019,2,8)

    c1 = Client.find(1)
    order11 = c1.orders.create(checkin_date: d0, checkout_date: d0.tomorrow, aasm_state: "order_pending", source: "電話")
    order11.order_items << RoomItem.create(name: "301-雅緻二人房", price: 2980, item_id: 1, adult_no: 2, kid_no: 2)
    order11.order_items << ServiceItem.create(name: "火鍋", price: 150, item_id: 1)
    order11.update(room_subtotal: 2980, bed_subtotal: 1000, service_subtotal: 150, total: 4130, downpay: 1000, credit_card: 1000, balance: 2130, pay_type: "現金", pay_info: "0000")
    # RoomCalendar.find_by(day: d0).update(r301: "#{c1.name}(#{c1.mobile}) x 4")

    order12 = c1.orders.create(checkin_date: d3, checkout_date: d3.tomorrow, aasm_state: "order_pending", source: "網路")
    order12.order_items << RoomItem.create(name: "301-雅緻二人房", price: 6600, item_id: 1, adult_no: 2, kid_no: 0)
    order12.order_items << RoomItem.create(name: "302-雅緻二人房", price: 6600, item_id: 2, adult_no: 2, kid_no: 0)
    order12.order_items << ServiceItem.create(name: "火鍋", price: 150, item_id: 1)
    order12.update(room_subtotal: 13200, bed_subtotal: 0, service_subtotal: 150, total: 13350, downpay: 5000, credit_card: 5000, balance: 3350, pay_type: "現金", pay_info: "0000")
    # RoomCalendar.find_by(day: d3).update(r301: "#{c1.name}(#{c1.mobile}) x 2")
    # RoomCalendar.find_by(day: d3).update(r302: "#{c1.name}(#{c1.mobile}) x 2")

    c2 = Client.find(2)
    order21 = c2.orders.create(checkin_date: d1, checkout_date: d1.tomorrow, aasm_state: "order_pending", source: "電話")
    order21.order_items << RoomItem.create(name: "303-經典二人房", price: 4620, item_id: 3, adult_no: 2, kid_no: 1)
    order21.update(room_subtotal: 4620, bed_subtotal: 1000, service_subtotal: 0, total: 5620, downpay: 1000, credit_card: 0, balance: 4620, pay_type: "現金", pay_info: "2222")
    # RoomCalendar.find_by(day: d1).update(r303: "#{c2.name}(#{c2.mobile}) x 3")

    c3 = Client.find(3)
    order31 = c3.orders.create(checkin_date: d0, checkout_date: d0.tomorrow, aasm_state: "order_pending", source: "電話")
    order31.order_items << RoomItem.create(name: "101-迎曦四人房", price: 3500, item_id: 6, adult_no: 4, kid_no: 1)
    order31.update(room_subtotal: 3500, bed_subtotal: 1000, service_subtotal: 0, total: 4500, downpay: 1000, credit_card: 1000, balance: 2500, pay_type: "現金", pay_info: "3333")
    # RoomCalendar.find_by(day: d0).update(r101: "#{c3.name}[HK](#{c3.mobile}) x 5")

    order32 = c3.orders.create(checkin_date: d2, checkout_date: d2.tomorrow, aasm_state: "order_pending", source: "網路")
    order32.order_items << RoomItem.create(name: "103-迎曦四人房", price: 4350, item_id: 8, adult_no: 4, kid_no: 1)
    order32.update(room_subtotal: 4350, bed_subtotal: 1000, service_subtotal: 0, total: 5350, downpay: 2000, credit_card: 0, balance: 2350, pay_type: "現金", pay_info: "3333")
    # RoomCalendar.find_by(day: d2).update(r103: "#{c3.name}[HK](#{c3.mobile}) x 5")

    c4 = Client.find(4)
    order41 = c4.orders.create(checkin_date: d1, checkout_date: d1.tomorrow, aasm_state: "order_pending", source: "電話")
    order41.order_items << RoomItem.create(name: "201-迎曦六人/家庭房", price: 5500, item_id: 10, adult_no: 5, kid_no: 2)
    order41.update(room_subtotal: 5500, bed_subtotal: 1000, service_subtotal: 0, total: 6500, downpay: 1000, credit_card: 1000, balance: 4500, pay_type: "現金", pay_info: "4444")
    # RoomCalendar.find_by(day: d1).update(r201: "#{c4.name}[HK](#{c4.mobile}) x 7")

    order42 = c4.orders.create(checkin_date: d3, checkout_date: d3.tomorrow, aasm_state: "order_pending", source: "網路")
    order42.order_items << RoomItem.create(name: "202-迎曦六人/家庭房", price: 8500, item_id: 11, adult_no: 5, kid_no: 2)
    order42.update(room_subtotal: 8500, bed_subtotal: 1000, service_subtotal: 0, total: 9500, downpay: 5000, credit_card: 0, balance: 4500, pay_type: "現金", pay_info: "4444")
    # RoomCalendar.find_by(day: d1).update(r202: "#{c4.name}[HK](#{c4.mobile}) x 7")

  # end
end

def test
    @order_days = []
    checkin_date = "2019/1/1"
    checkout_date= "2019/1/3"
    if checkin_date
      begin_day = Date.parse(checkin_date)
      @order_days << begin_day.to_s(:db)
      if checkout_date

        end_day = Date.parse(checkout_date)

        day = begin_day.tomorrow
        until day >= end_day do
          @order_days << day.to_s(:db)
          day = day.tomorrow
        end
      end
    end
    puts @order_days
end


  def calculate_daily_satistics(search_date)
    chalet_cash, chalet_credit, chalet_total, chalet_count = 0, 0, 0, 0
    villa_cash, villa_credit, villa_total, villa_count = 0, 0, 0, 0
    daily_cash, daily_credit, daily_total, daily_count = 0, 0, 0, 0
    chalet_rooms, villa_rooms, total_rooms = 6.0, 7.0, 13.0

    daily_statistics = []
    room_statistics = []

    Room.select(:no).each do | room |
      room_hash = RoomCalendar.find_by(day: search_date).get_room_hash(room.no.to_s)
      if room_hash.size > 0
        cash = room_hash["cash"]
        credit = room_hash["credit_card"]
        total = room_hash["room_total"]

        room_statistics << cash << credit << total
        puts "room: no[#{room.no}], cash[#{cash}], credit[#{credit}], total[#{total}]"

        case room.no.to_s
        when "105", "301", "302", "303", "305", "306"
          chalet_cash  += cash
          chalet_credit+= credit
          chalet_total += total
          chalet_count += 1
        else
          villa_cash   += cash
          villa_credit += credit
          villa_total  += total
          villa_count  += 1
        end

        daily_cash   += cash
        daily_credit += credit
        daily_total  += total
        daily_count  += 1

      else
        room_statistics << 0 << 0 << 0
      end
    end

    daily_ratio = 100* (daily_count / total_rooms)
    daily_statistics << daily_cash << daily_credit << daily_total
    # puts "daily: no[#{daily_count}], cash[#{daily_cash}], credit[#{daily_credit}], total[#{daily_total}], ratio[#{daily_ratio.round(2)}]"

    chalet_ratio = 100* (chalet_count / chalet_rooms)
    daily_statistics << chalet_cash << chalet_credit << chalet_count << chalet_ratio.round(1)
    # puts "chalet: no[#{chalet_count}], cash[#{chalet_cash}], credit[#{chalet_credit}], ratio[#{chalet_ratio.round(2)}]"

    villa_ratio = 100* (villa_count / villa_rooms)
    daily_statistics << villa_cash << villa_credit << villa_total << villa_ratio.round(1)
    # puts "villa: no[#{villa_count}], cash[#{villa_cash}], credit[#{villa_credit}], ratio[#{villa_ratio.round(2)}]"
    daily_statistics << daily_ratio.round(1)
    daily_statistics += room_statistics

    puts daily_statistics
    # puts room_statistics
    daily_statistics
  end

# require "prawn"

# def test_pdf
#   Prawn::Document.generate("hello.pdf") do
#     text "Hello World!"
#   end
# end

# ------------------------------
# Main
# ------------------------------
setup_accounts
setup_rooms
setup_services
setup_calandar(2019, 2022)
setup_2019calandar_special_days
setup_clients

# setup_orders
# test
# test2

# calculate_daily_satistics(Date.today)
# test_pdf
