class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:edit, :update, :destroy, :show, :down_pay, :full_pay, :check_in, :check_out, :suspend, :reorder, :cancel]
  before_action :set_search_date, only: [:index, :daily]

  # 讓 view 也能用，要掛上helper_method
  helper_method :current_cart

  # 接待/客戶管理 -> 依日期查詢
  def index
    # if params.has_key?(:search_date) && params[:search_date].present?
    #   @search_date = Date.parse(params[:search_date])
    #   @orders = Order.where('checkin_date = ? OR (created_at >= ? and created_at <= ?)', @search_date, @search_date.beginning_of_day, @search_date.end_of_day)
    # else
    #   @orders = []
    # end
    @room_items = get_daily_room_items(@search_date)

  end

  # 訂房/訂單管理 -> 待處理訂單
  def pending
    @orders = Order.where('aasm_state = ?', "order_pending")
  end

  # 接待/客戶管理 -> Check-in(當日入住名單)
  def daily
    @orders = get_daily_room_orders(@search_date)
    # @room_items = get_daily_room_items(@search_date)
    # @room_items = OrderItem.where("type='RoomItem' AND day = ?", @search_date)
  end

  # 接待/客戶管理 -> 訂單登入
  def new
    current_cart.clean!

    if params.has_key?(:client_id)
      @client = Client.find(params[:client_id])
      @order = @client.orders.build(name: @client.name, sex: @client.sex, mobile: @client.mobile,
        country: @client.country, id_no: @client.id_no, birthday: @client.birthday, job: @client.job,
        tel: @client.tel, address: @client.address, email: @client.email,
        reminder: @client.reminder, note: @client.note)
    else
      @client = Client.new
      @order = @client.orders.build
      # @order = Order.new
    end
  end

  # 接待/客戶管理 -> 訂單登入(儲存)
  def create
    @order = Order.new(order_params)
    # 是否為現有客戶
    if @order.is_old_client?
      @client = Client.find(@order.client_id)
    else
      @client = Client.new
    end

    @order.build_items_from_cart(current_cart)
    # 根據相關金額更改狀態
    @order.down_pay if @order.total > @order.balance
    @order.full_pay if @order.balance == 0
    @client.orders << @order

    @order.copy_client_data(@client)
    if @client.save
      current_cart.clean!

      redirect_to order_path(@order), notice: "新增訂單(#{@order.name})成功"
      # redirect_to weekly_admin_room_calendars_path, notice: "新增訂單(#{@order.name})成功"
    else
      flash[:warning] = "新增訂單(#{@order.name})失敗"
      render :new
    end

  end

  # 搜尋客戶資料
  def search_clients
    if params.has_key?(:name)
      @search_name = params[:name]
      @clients = Client.where('lower(name) LIKE ?', "%#{@search_name.downcase}%")
    else
      @clients = []
    end
  end

  # 列出房間服務
  def list_services
    @order_days = get_order_dates
    @services = Service.all
  end

  # 列出房間列表
  def list_rooms
    @order_days = get_order_dates
    @calendar_items = get_room_items(@order_days)
  end

  def current_cart
    @current_cart ||= find_cart
  end

  def add_to_cart
    if params[:cart_item][:kind].present? && params[:cart_item][:kind] == CartItem::Service_Type
      @kind = CartItem::Service_Type
      service_item = CartItem.new(day: params[:cart_item][:day], kind: @kind,
        name: params[:cart_item][:name], price: params[:cart_item][:price], item_id: params[:id])
      @cart_item = current_cart.add_item_to_cart(service_item)
    end

    if params[:cart_item][:kind].present? && params[:cart_item][:kind] == CartItem::Room_Type
      @kind = CartItem::Room_Type
      room_item = CartItem.new(day: params[:cart_item][:day], kind: @kind,
        name: params[:cart_item][:name], price: params[:cart_item][:price],
        add_bed_no: params[:cart_item][:add_bed_no], add_bed_fee: params[:cart_item][:add_bed_fee],
        adult_no: params[:cart_item][:adult_no], kid_no: params[:cart_item][:kid_no],
        baby_no: params[:cart_item][:baby_no], item_id: params[:cart_item][:item_id])
      @cart_item = current_cart.add_item_to_cart(room_item)
    end

      # redirect_back fallback_location: product_path(@product)
  end

  def show
  end

  def edit
    current_cart.clean!
  end

  def update
    @client = Client.find(@order.client_id)
    @order.build_items_from_cart(current_cart)

    if @order.update(order_params)
      @order.copy_client_data(@client)
      @client.save

      # 根據相關金額更改狀態
      @order.down_pay if @order.total > @order.balance
      @order.full_pay if @order.balance == 0
      @order.save
      # @order.update_room_calendars

      current_cart.clean!
      # redirect_to new_order_path, notice: "新增訂單(#{@order.name})成功"
      redirect_to weekly_admin_room_calendars_path, notice: "更新訂單(#{@order.name})成功"
    else
      flash[:warning] = "更新訂單(#{@order.name})失敗"
      render :edit
    end

  end

  def destroy
    @order.destroy
    redirect_to weekly_admin_room_calendars_path, alert: "訂單(#{@order.name})已刪除!"
  end

  def check_in
    @order.check_in
    if @order.save
      redirect_to weekly_admin_room_calendars_path, notice: "訂單(#{@order.name})入住成功"
    else
      redirect_back fallback_location: order_path(@order)
    end
  end

  def check_out
    @order.check_out
    if @order.save
      redirect_to weekly_admin_room_calendars_path, notice: "訂單(#{@order.name})退房成功"
    else
      redirect_back fallback_location: order_path(@order)
    end
  end

  def suspend
    @order.suspend
    if @order.save
      redirect_to weekly_admin_room_calendars_path, notice: "訂單(#{@order.name})保留成功"
    else
      redirect_back fallback_location: order_path(@order)
    end

  end

  def reorder
    @order.reorder
    if @order.save
      redirect_to weekly_admin_room_calendars_path, notice: "重新下單(#{@order.name})成功"
    else
      redirect_back fallback_location: order_path(@order)
    end

  end

  def cancel
    @order.cancel
    if @order.save
      redirect_to weekly_admin_room_calendars_path, notice: "訂單(#{@order.name})取消成功"
    else
      redirect_back fallback_location: order_path(@order)
    end

  end

private
  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:checkin_date, :checkout_date, :aasm_state, :source,
      :room_subtotal, :bed_subtotal, :service_subtotal, :total, :downpay, :credit_card,
      :balance, :pay_type, :pay_info, :client_id,
      :name, :sex, :mobile, :country, :id_no, :birthday, :job, :tel, :address, :email, :reminder, :note,
      :adult_subtotal, :kid_subtotal, :baby_subtotal)
  end

  # 回傳「入住日期」至「退房日期」的所有日期
  def get_order_dates
    order_days = []
    if params.has_key?(:checkin_date) && params[:checkin_date].size > 0
      begin_day = Date.parse(params[:checkin_date])
      order_days << begin_day

      if params.has_key?(:checkout_date) && params[:checkout_date].size > 0
        end_day = Date.parse(params[:checkout_date])

        day = begin_day.tomorrow
        until day >= end_day do
          order_days << day
          day = day.tomorrow
        end
      end
    end

    order_days
  end

  def get_room_items(order_days)
    rooms = Room.all

    calendar_items = []
    rooms.each do |room|
      room_days = []
      order_days.each do | day |
        item = CartItem.new
        item.day = day
        item.kind = "Room"
        item.name = "#{room.no}-#{room.name}"
        item.add_bed_fee = room.add_bed_fee
        item.item_id = room.id

        room_calendar = RoomCalendar.find_by_day(day)

        if room_calendar.is_occupaied?(room.no)
          item.price = RoomCalendar::Occupaied_Price
        else
          item.price = room_calendar.get_price(room.no)
        end

        room_days << item
      end

      calendar_items << room_days
    end

    calendar_items
  end

  def find_cart
    cart = Cart.find_by(id: session[:cart_id])

    unless cart.present?
      cart = Cart.create
    end

    session[:cart_id] = cart.id
    cart
  end


end
