class Admin::RoomCalendarsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required

  before_action :set_room_calendar, only: [:to_dealday, :to_holiday, :to_hotday, :to_weekday]

  helper_method :get_color

  # 行事曆設定
  def index
    @room_calendars = RoomCalendar.all.order(:day)
  end

  # 依房間查詢(月曆形式)
  def calendar
    @room_no = "r301"
    @room_no = params[:room] if params.has_key?(:room) && params[:room].present?
    @events_url = "/admin/room_calendars/calendar.json?room=#{@room_no}"
    # @room_calendars = RoomCalendar.select("id, day, day_info, #{@room_no} AS title")
    @room_calendars = RoomCalendar.select("id, day, day_info, #{@room_no}, #{@room_no} AS title, #{@room_no} AS color, #{@room_no} AS url")
      .where("day >= :start_date AND day <= :end_date",
      {start_date: Date.current.beginning_of_month, end_date: Date.current.end_of_month}).order(:day)

    @room_calendars.each do |cal|
      room_hash = cal.get_room_hash(@room_no[1,3])
      cal.title = room_hash["summary"]
      order_id = (room_hash["order_id"].present?) ? room_hash["order_id"] : 0

      cal.url = order_path(order_id)
      # cal.url = link_to("", order_path(order_id), remote: true)
      index = (room_hash["order_id"].present?) ? room_hash["order_id"]%10 : 0
      cal.color = get_color(index)
    end

  end

  def get_color(index)
    td_bgcolors = ["lightcyan", "lightblue", "palegreen", "lightyellow", "lightpink", "lavender" ,"lightgray", "lightgreen", "yellow", "lightskyblue"]
    index %= 10
    td_bgcolors[index]
  end

  # 當周訂房狀況
  def weekly
    @search_date = Date.today
    @search_date = Date.parse(params[:search_date]) if params.has_key?(:search_date) && params[:search_date].present?

    @room_calendars = RoomCalendar.where("day >= :start_date AND day <= :end_date",
      {start_date: @search_date.beginning_of_week, end_date: @search_date.end_of_week}).order(:day)
  end

  # 當月訂房狀況
  def monthly
    @room_calendars = RoomCalendar.where("day >= :start_date AND day <= :end_date",
      {start_date: Date.current.beginning_of_month, end_date: Date.current.end_of_month}).order(:day)
  end

  def to_dealday
    @room_calendars.to_dealday

    redirect_to calendar_admin_room_calendars_path
  end

  def to_holiday
    @room_calendars.to_holiday

    redirect_to calendar_admin_room_calendars_path
  end

  def to_hotday
    @room_calendars.to_hotday

    redirect_to calendar_admin_room_calendars_path
  end

  def to_weekday
    @room_calendars.to_weekday

    redirect_to calendar_admin_room_calendars_path
  end

  private

  def set_room_calendar
    @room_calendars = RoomCalendar.find(params[:id])
  end

end
