class Order < ApplicationRecord
  validates_presence_of :checkin_date, :checkout_date, :name

  belongs_to :client

  has_many :order_items, dependent: :destroy

  has_many :room_items,  -> { where( type: "RoomItem" ) }, class_name: "OrderItem"
  has_many :service_items, -> { where( type: "ServiceItem" ) }, class_name: "OrderItem"


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

end
