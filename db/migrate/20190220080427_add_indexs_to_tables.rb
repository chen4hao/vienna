class AddIndexsToTables < ActiveRecord::Migration[5.2]
  def change
    add_index :clients, :name
    add_index :clients, :mobile

    add_index :orders, :name
    add_index :orders, :mobile
    add_index :orders, :aasm_state

    add_index :order_items, :day
    add_index :order_items, :type

    add_index :room_calendars, :day

    add_index :rooms, :no
    add_index :services, :name

    add_index :statistics, :day
    add_index :statistics, :kind

  end
end
