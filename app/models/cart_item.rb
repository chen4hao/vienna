class CartItem < ApplicationRecord
  Service_Type = "Service"
  Room_Type = "Room"
  belongs_to :cart
end
