class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :name
      t.integer :list_price, default: 0
      t.integer :custom_price, default: 0
      t.string :category

      t.timestamps
    end
  end
end
