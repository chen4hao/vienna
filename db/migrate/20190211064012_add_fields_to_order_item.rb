class AddFieldsToOrderItem < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :day, :date
    add_column :order_items, :add_bed_no, :integer, default: 0
    add_column :order_items, :add_bed_fee, :integer, default: 0
  end
end
