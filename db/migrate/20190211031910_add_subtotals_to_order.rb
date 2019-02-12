class AddSubtotalsToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :adult_subtotal, :integer, default: 0
    add_column :orders, :kid_subtotal, :integer, default: 0
    add_column :orders, :baby_subtotal, :integer, default: 0
  end
end
