class Order < ApplicationRecord
  belongs_to :client

  has_many :order_items, dependent: :destroy

  has_many :room_items,  -> { where( type: "RoomItem" ) }, class_name: "OrderItem"
  has_many :service_items, -> { where( type: "ServiceItem" ) }, class_name: "OrderItem"

end
