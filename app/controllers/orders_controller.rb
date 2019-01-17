class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:edit, :update, :destroy, :show]

  def index
    if params.has_key?(:search_date) && params[:search_date].present?
      search_date = Date.parse(params[:search_date])
      @orders = Order.where('checkin_date = ? OR (created_at >= ? and created_at <= ?)', search_date, search_date.beginning_of_day, search_date.end_of_day)
    else
      @orders = []
    end

  end

end
