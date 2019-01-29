class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:edit, :update, :destroy, :show]

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

    @client.name     = @order.name
    @client.sex      = @order.sex
    @client.mobile   = @order.mobile
    @client.country  = @order.country
    @client.id_no    = @order.id_no
    @client.birthday = @order.birthday
    @client.job      = @order.job
    @client.tel      = @order.tel
    @client.address  = @order.address
    @client.email    = @order.email
    @client.reminder = @order.reminder
    @client.note     = @order.note

    @client.orders << @order

    if @client.save
      redirect_to new_order_path, notice: "新增訂單(#{@order.name})成功"
    else
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

private
  def order_params
    params.require(:order).permit(:checkin_date, :checkout_date, :aasm_state, :source,
      :room_subtotal, :bed_subtotal, :service_subtotal, :total, :downpay, :credit_card,
      :balance, :pay_type, :pay_info, :client_id,
      :name, :sex, :mobile, :country, :id_no, :birthday, :job, :tel, :address, :email, :reminder, :note)
  end

end
