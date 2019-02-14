class CreateStatistics < ActiveRecord::Migration[5.2]
  def change
    create_table :statistics do |t|
      t.date :day
      t.string :name
      t.string :kind
      t.integer :cash, default: 0
      t.integer :credit_card, default: 0
      t.integer :total, default: 0
      t.integer :checkin_no, default: 0
      t.decimal :checkin_ratio, precision: 3, scale: 2, default: 0.00

      t.timestamps
    end
  end
end
