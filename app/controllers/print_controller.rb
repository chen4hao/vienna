class PrintController < ApplicationController

  # 表單列印 -> 當日房客明細表
  def orders
    @search_date = Date.today
    @search_date = Date.parse(params[:search_date]) if params.has_key?(:search_date) && params[:search_date].present?

    @room_items = OrderItem.where("type='RoomItem' AND day = ?", @search_date)

  end
end
