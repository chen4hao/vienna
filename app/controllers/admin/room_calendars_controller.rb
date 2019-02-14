class Admin::RoomCalendarsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required

  before_action :set_room_calendar, only: [:to_dealday, :to_holiday, :to_hotday, :to_weekday]

  helper_method :get_room_summary


  # 行事曆設定
  def index
    @room_calendars = RoomCalendar.all.order(:day)
  end

  # 依房間查詢(月曆形式)
  def calendar
    @room_no = "r301"
    @room_no = params[:room] if params.has_key?(:room) && params[:room].present?
    @events_url = "/admin/room_calendars/calendar.json?room=#{@room_no}"
    @room_calendars = RoomCalendar.select("id, day, day_info, #{@room_no} AS title")
      .where("day >= :start_date AND day <= :end_date",
      {start_date: Date.current.beginning_of_month, end_date: Date.current.end_of_month}).order(:day)

    @room_calendars.each do |cal|
      cal.title = get_room_summary(cal.title)
    end

  end

  def get_room_summary(room_json)
    summary = ""
    if room_json.present?
      # json to hash
      room_hash = JSON.parse room_json.gsub!('=>', ':')
      summary = room_hash["summary"]
    end
    summary
  end

  # 當月訂房狀況
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
