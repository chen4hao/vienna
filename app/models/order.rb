class Order < ApplicationRecord
  belongs_to :client

  has_many :order_items, dependent: :destroy

  has_many :room_items,  -> { where( type: "RoomItem" ) }, class_name: "OrderItem"
  has_many :service_items, -> { where( type: "ServiceItem" ) }, class_name: "OrderItem"

  # def country_name
  #   country = ISO3166::Country[nation]
  #   country.translations[I18n.locale.to_s] || country.name
  # end

end
