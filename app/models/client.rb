class Client < ApplicationRecord
  has_many :orders, dependent: :destroy

  # accepts_nested_attributes_for :orders
end
