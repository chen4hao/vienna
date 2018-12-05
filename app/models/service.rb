class Service < ApplicationRecord
  validates_presence_of :name, :list_price
  validates_numericality_of :list_price, only_integer: true

end
