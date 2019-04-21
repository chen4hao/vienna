class ApplicationController < ActionController::Base
  include DeviseWhitelist

  # 讓 view 也能用，要掛上helper_method
  helper_method :render_day
  helper_method :render_fullday

  def admin_required
    if !current_user.admin?
      redirect_to "/"
    end
  end

  # 顯示"%m-%d (%a)"的日期格式，如：03-01(一)
  def render_day(day)
    I18n.l(day, format: :calendar )
  end

  # 顯示"%Y-%m-%d (%a)"的日期格式，如：2019-03-01(一)
  def render_fullday(day)
    I18n.l(day, format: :full )
  end

  private

  # 設定搜尋日期，預設為今日
  def set_search_date
    @search_date = Date.current
    @search_date = Date.parse(params[:search_date]) if params.has_key?(:search_date) && params[:search_date].present?
  end

  # 抓取當日訂單房間項目
  def get_daily_room_items(search_date)
    room_items = []

    room_calendar = RoomCalendar.find_by(day: search_date)
    # rooms = Room.select(:no)
    rooms = Room.select(:no).order("created_at")
    rooms.each do |room|
      if room_calendar.is_occupaied?(room.no.to_s)
        room_hash = room_calendar.get_room_hash(room.no.to_s)
        order_id = room_hash["order_id"]
        order = Order.find(order_id)
        order.room_items.each do | item |
          if !room_items.include?(item)
            room_items << item if item.day == search_date
          end
        end
      end
    end
    room_items
  end

  # 抓取當日訂單
  def get_daily_room_orders(search_date)
    room_orders = []

    room_calendar = RoomCalendar.find_by(day: search_date)
    # rooms = Room.select(:no)
    rooms = Room.select(:no).order("created_at")
    rooms.each do |room|
      if room_calendar.is_occupaied?(room.no.to_s)
        room_hash = room_calendar.get_room_hash(room.no.to_s)
        order_id = room_hash["order_id"]
        order = Order.find(order_id)
        room_orders << order if !room_orders.include?(order)
      end
    end
    room_orders
  end

end
