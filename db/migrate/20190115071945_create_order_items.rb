class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.string :name
      t.string :type
      t.integer :price, default: 0
      t.integer :item_id
      t.integer :adult_no, default: 0
      t.integer :kid_no, default: 0
      t.integer :baby_no, default: 0
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
