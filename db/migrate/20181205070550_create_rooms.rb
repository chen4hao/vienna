class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :no
      t.string :name
      t.integer :list_price, default: 0
      t.integer :holiday_price, default: 0
      t.integer :hotday_price, default: 0
      t.integer :weekday_price, default: 0
      t.integer :custom_price, default: 0
      t.integer :add_bed_fee, default: 0

      t.timestamps
    end
  end
end
