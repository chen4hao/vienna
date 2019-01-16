class OrderItem < ApplicationRecord
  belongs_to :order
end


class RoomItem < OrderItem
end

class ServiceItem < OrderItem
end
