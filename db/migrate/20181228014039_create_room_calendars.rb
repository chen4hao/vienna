class CreateRoomCalendars < ActiveRecord::Migration[5.2]
  def change
    create_table :room_calendars do |t|
      t.date :day
      t.integer :day_mode, default: 0
      t.string :day_info
      t.string :r301
      t.string :r302
      t.string :r303
      t.string :r305
      t.string :r306
      t.string :r101
      t.string :r102
      t.string :r103
      t.string :r105
      t.string :r201
      t.string :r202
      t.string :r203
      t.string :r205

      t.timestamps
    end
  end
end
