class Admin::RoomCalendarsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required

  before_action :set_room_calendar, only: [:to_dealday, :to_holiday, :to_hotday, :to_weekday]


  def index
    @room_calendars = RoomCalendar.all
  end

  def calendar
    @room_calendars = RoomCalendar.all
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
