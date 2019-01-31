class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.string :name
      t.string :kind
      t.date :day
      t.integer :price, default: 0
      t.integer :add_bed_no, default: 0
      t.integer :add_bed_fee, default: 0
      t.integer :adult_no, default: 0
      t.integer :kid_no, default: 0
      t.integer :baby_no, default: 0
      t.integer :cart_id
      t.integer :item_id

      t.timestamps
    end
  end
end
