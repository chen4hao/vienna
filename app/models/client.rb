class Client < ApplicationRecord
  validates_presence_of :name

  has_many :orders, dependent: :destroy

  # accepts_nested_attributes_for :orders
end
