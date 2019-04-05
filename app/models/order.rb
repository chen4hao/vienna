class Order < ApplicationRecord
  extend Utility
  validates_presence_of :checkin_date, :checkout_date, :name

  belongs_to :client

  has_many :order_items, dependent: :destroy

  has_many :room_items,  -> { where( type: "RoomItem" ) }, class_name: "OrderItem"
  has_many :service_items, -> { where( type: "ServiceItem" ) }, class_name: "OrderItem"

  # after_destroy :clear_room_calendars
  after_save :update_room_calendars
  # after_commit :update_room_calendars

  def update_room_calendars
    room_items.each do |item|
      item.update_room_calendar
    end
  end

  def clear_room_calendars
    room_items.each do |item|
      item.clear_room_calendar
    end
  end

  def is_old_client?
    client_id.present?
  end

  def copy_client_data(client)
    client.name     = name
    client.sex      = sex
    client.mobile   = mobile
    client.country  = country
    client.id_no    = id_no
    client.birthday = birthday
    client.job      = job
    client.tel      = tel
    client.address  = address
    client.email    = email
    client.reminder = reminder
    client.note     = note
  end

  def build_items_from_cart(cart)
    cart.cart_items.each do | cart_item |
      if cart_item.kind == CartItem::Service_Type
        item = OrderItem.new(type: "ServiceItem", day: cart_item.day, name: cart_item.name, price: cart_item.price,
          item_id: cart_item.item_id)
        order_items << item
      elsif cart_item.kind == CartItem::Room_Type
        item = OrderItem.new(type: "RoomItem", day: cart_item.day, name: cart_item.name, price: cart_item.price,
          item_id: cart_item.item_id, add_bed_no: cart_item.add_bed_no, add_bed_fee: cart_item.add_bed_fee,
          adult_no: cart_item.adult_no, kid_no: cart_item.kid_no, baby_no: cart_item.baby_no)
        order_items << item
      end
    end
  end

  include AASM
  aasm do
    state :order_placed, initial: true
    state :down_paid
    state :full_paid
    state :checked_in
    state :checked_out
    state :order_pending
    state :order_cancelled

    event :down_pay do
      transitions from: :order_placed,                to: :down_paid
    end

    event :full_pay do
      transitions from: [:order_placed, :down_paid],  to: :full_paid
    end

    event :check_in do
      transitions from: [:order_placed, :down_paid, :full_paid], to: :checked_in
    end

    event :check_out do
      transitions from: :checked_in,                  to: :checked_out
    end

    event :suspend do
      transitions from: [:order_placed, :down_paid, :full_paid],  to: :order_pending
    end

    event :reorder do
      transitions from: :order_pending,               to: :order_placed
    end

    event :cancel do
      transitions from: :order_pending,               to: :order_cancelled
    end
  end

  # 輸出成csv格式 
  def self.to_csv(is_4_db=false, options = {})
    desired_columns = ["checkin_date", "checkout_date", "aasm_state", "source",
      "name", "sex", "mobile", "country", "id_no", "birthday", "job", "tel", "address", "email", "reminder", "note",
      "room_subtotal", "bed_subtotal", "service_subtotal", "total", "downpay", "credit_card", "balance",
      "pay_type", "pay_info", "adult_subtotal", "kid_subtotal", "baby_subtotal"]
    export_columns = ["入住日", "退房日", "狀態", "來源",
      "姓名", "性別", "手機", "國別", "身分證/護照", "生日", "職業", "電話", "地址", "email", "提醒(外)", "備註(內)",
      "房費小計", "加床小計", "服務小計", "總額", "訂金", "信用卡", "餘額",
      "支付方式", "末五碼", "大人人數", "小孩人數", "幼兒人數"]

    to_csv_string(desired_columns, export_columns)
  end

end
