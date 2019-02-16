class PrintController < ApplicationController
  before_action :set_search_date, only: [:orders, :abstract, :clients]

  # 表單列印 -> 當日房客明細表
  def orders
    @room_items = OrderItem.where("type='RoomItem' AND day = ?", @search_date)
  end

  # 表單列印 -> 當日住宿簡表
  def abstract
    room_calendar = RoomCalendar.find_by(day: @search_date)
    rooms = Room.select(:no)

    @empty_rooms = "空房列表："
    @occupaied_rooms = {}

    rooms.each do |room|
      if room_calendar.is_occupaied?(room.no.to_s)
        room_hash = room_calendar.get_room_hash(room.no.to_s)
        summary_key = room_hash["client_name"]
        if @occupaied_rooms.has_key?(summary_key)
          room_values = @occupaied_rooms[summary_key]
          @occupaied_rooms.store(summary_key, room_values + "、" + room.no.to_s)
        else
          @occupaied_rooms.store(summary_key, room.no.to_s)
        end

      else
        @empty_rooms += room.no.to_s + "、"
      end
    end
  end

  # 表單列印 -> 當日房客資料表
  def clients
    order_ids = OrderItem.select(:order_id).distinct.where(day: @search_date)
    @orders = []
    order_ids.each do |item|
      @orders << Order.find(item.order_id)
    end

  end
end