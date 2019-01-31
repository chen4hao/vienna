class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:edit, :update, :destroy, :show]

  # 讓 view 也能用，要掛上helper_method
  helper_method :current_cart

  # 接待/客戶管理 -> 依日期查詢
  def index
    if params.has_key?(:search_date) && params[:search_date].present?
      search_date = Date.parse(params[:search_date])
      @orders = Order.where('checkin_date = ? OR (created_at >= ? and created_at <= ?)', search_date, search_date.beginning_of_day, search_date.end_of_day)
    else
      @orders = []
    end
  end

  # 接待/客戶管理 -> 訂單登入
  def new
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

  def create
    @order = Order.new(order_params)
    if @order.client_id.present?
      @client = Client.find(@order.client_id)
    else
      @client = Client.new
    end

    copy_client_data(@client, @order)

    @client.orders << @order

    if @client.save
      update_room_calendar(@order)
      redirect_to new_order_path, notice: "新增訂單(#{@order.name})成功"
    else
      flash[:warning] = "新增訂單(#{@order.name})失敗"
      render :new
    end

  end

  def search_clients
    if params.has_key?(:name)
      @search_name = params[:name]
      @clients = Client.where('lower(name) LIKE ?', "%#{@search_name.downcase}%")
    else
      @clients = []
    end
  end

  def list_services
    # @order_days = ["2019/1/1", "2019/1/2", "2019/1/3"]
    @order_days = get_order_days
    @services = Service.all

  end

  def list_rooms
    @order_days = get_order_days
    @rooms = Room.all
    # @room_calendars = []
    @order_days.each do | day |
      @rooms.each do |room|
        item = CartItem.new
        item.day = day
        item.kind = "Room"
        item.name = "#{room.no}-#{room.name}"
        item.add_bed_fee = room.add_bed_fee

        room_calendar = RoomCalendar.find_by_day(Date.parse(day))
        case room_calendar.day_mode
          when RoomCalendar.Day_Mode_Dealday
            item.price = room.dealday_price
          when RoomCalendar.Day_Mode_Holiday
            item.price = room.holiday_price
          when RoomCalendar.Day_Mode_Hotday
            item.price = room.hotday_price
          else
            item.price = room.weekday_price
        end

        puts item
      end
    end
  end

  def current_cart
    @current_cart ||= find_cart
  end

  def add_to_cart
    if params[:kind].present? && params[:kind] == "Service"
      @service = Service.find(params[:id])
      @cart_item = current_cart.add_service_to_cart(@service, Date.parse(params[:day]), params[:price])
    end
      # redirect_back fallback_location: product_path(@product)
  end


private
  def order_params
    params.require(:order).permit(:checkin_date, :checkout_date, :aasm_state, :source,
      :room_subtotal, :bed_subtotal, :service_subtotal, :total, :downpay, :credit_card,
      :balance, :pay_type, :pay_info, :client_id,
      :name, :sex, :mobile, :country, :id_no, :birthday, :job, :tel, :address, :email, :reminder, :note)
  end

  def copy_client_data(client, order)
    client.name     = order.name
    client.sex      = order.sex
    client.mobile   = order.mobile
    client.country  = order.country
    client.id_no    = order.id_no
    client.birthday = order.birthday
    client.job      = order.job
    client.tel      = order.tel
    client.address  = order.address
    client.email    = order.email
    client.reminder = order.reminder
    client.note     = order.note
  end

  # TODO: update_room_calendar
  def update_room_calendar(order)


    # RoomCalendar.find_by(day: d0).update(r301: "#{c1.name}(#{c1.mobile}) x 4")
  end

  # 回傳「入住日期」至「退房日期」的所有日期
  def get_order_days
    order_days = []
    if params.has_key?(:checkin_date) && params[:checkin_date].size > 0
      begin_day = Date.parse(params[:checkin_date])
      order_days << begin_day.to_s(:db)

      if params.has_key?(:checkout_date) && params[:checkout_date].size > 0
        end_day = Date.parse(params[:checkout_date])

        day = begin_day.tomorrow
        until day >= end_day do
          order_days << day.to_s(:db)
          day = day.tomorrow
        end
      end
    end

    order_days
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
