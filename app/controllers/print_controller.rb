class PrintController < ApplicationController
  before_action :authenticate_user!
  before_action :set_search_date, only: [:orders, :abstract, :clients]

  # 表單列印 -> 當日房客明細表
  def orders
    # @room_items = get_daily_room_items(@search_date)
    @orders = get_daily_room_orders(@search_date)
  end

  # 表單列印 -> 當日住宿簡表
  def abstract
    room_calendar = RoomCalendar.find_by(day: @search_date)
    # rooms = Room.select(:no)
    rooms = Room.select(:no).order("created_at")

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
    @orders = get_daily_room_orders(@search_date)
  end

  def export
    @option = params[:option] if params.has_key?(:option) && params[:option].present?
    @target = params[:target] if params.has_key?(:target) && params[:target].present?

    case @target
    when "Clients"
      @data_instances = Client.all
    when "Rooms"
      @data_instances = Room.all
    when "Orders"
      @data_instances = Order.all
    when "Services"
      @data_instances = Service.all
    when "Calendars"
      @data_instances = RoomCalendar.all
    else
    end

    respond_to do |format|
      format.html
      format.csv {
        if @option == "4DB"
          send_data @data_instances.to_csv(true)
        else
          send_data @data_instances.to_csv
        end
      }
      format.xls
    end

  end
end
