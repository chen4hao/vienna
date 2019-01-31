class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy

  def add_service_to_cart(service, day, price)
    ci = cart_items.build
    ci.day = day
    ci.kind = "Service"
    ci.item_id = service.id
    ci.name = service.name
    ci.price = price
    ci.save
    ci
  end
end
