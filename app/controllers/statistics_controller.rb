class StatisticsController < ApplicationController

  # 統計報表 -> 日報
  def daily
    @search_date = Date.today
    @search_date = Date.parse(params[:search_date]) if params.has_key?(:search_date) && params[:search_date].present?

    @statistics = Statistic.find_by(day: @search_date)

    @room_items = OrderItem.where("type='RoomItem' AND day = ?", @search_date)

  end
end
