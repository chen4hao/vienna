class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.date :checkin_date
      t.date :checkout_date
      t.string :aasm_state
      t.string :source
      t.integer :room_subtotal, default: 0
      t.integer :bed_subtotal, default: 0
      t.integer :service_subtotal, default: 0
      t.integer :total, default: 0
      t.integer :downpay, default: 0
      t.integer :credit_card, default: 0
      t.integer :balance, default: 0
      t.string :pay_type
      t.string :pay_info
      t.string :created_by
      t.string :updated_by
      t.references :client, foreign_key: true

      t.timestamps
    end
  end
end
