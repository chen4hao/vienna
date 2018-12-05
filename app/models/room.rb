class Room < ApplicationRecord
  validates_presence_of :no, :name, :list_price, :holiday_price, :hotday_price, :weekday_price
  validates_numericality_of :list_price, :holiday_price, :hotday_price, :weekday_price, only_integer: true

end
