class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy

  def add_item_to_cart(item)
    cart_items << item
    item.save
    item
  end

  def remove_item_to_cart(item)
    cart_items.delete(item)
    item.destroy
  end

  def clean!
    cart_items.destroy_all
  end

end
